import BagbutikSpecDecoder
import Foundation
import Stencil
import StencilSwiftKit
import SwiftFormat

public class ObjectSchemaRenderer {
    public init() {}

    public func render(objectSchema: ObjectSchema, includesFixUps: [String] = []) throws -> String {
        let context = objectContext(for: objectSchema, in: environment, includesFixUps: includesFixUps)
        let rendered = try environment.renderTemplate(name: "objectTemplate", context: context)
        return try SwiftFormat.format(rendered)
    }

    private static let constantTemplate = """
    public var {{ id|escapeReservedKeywords }}: String { "{{ value }}" }
    """
    private static let objectTemplate = #"""
    public struct {{ name|upperFirstLetter }}: Codable{% if isRequest %}, RequestBody{% endif %} {
        {% for property in properties %}
        {{ property }}{%
        endfor %}{%
        if attributes.count > 0 %}
        public let attributes: Attributes{% if attributesOptional %}?{% endif %}{% endif %}{%
        if hasRelationships %}
        public let relationships: Relationships{% if relationshipsOptional %}?{% endif %}{% endif %}

        public init({{ publicInit }}) {
            {% for propertyName in propertyNames %}{% if propertyName.idealName != "type" %}
            self.{{ propertyName.idealName|escapeReservedKeywords }} = {{ propertyName.safeName }}{%
            endif %}{% endfor %}
        }
        {% if needsCustomCoding %}
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self){%
            for codableProperty in codableProperties %}{%
            if codableProperty.optional %}
            {{ codableProperty.name }} = try container.decodeIfPresent({{ codableProperty.type }}.self, forKey: .{{ codableProperty.name }}){%
            else %}
            {{ codableProperty.name }} = try container.decode({{ codableProperty.type }}.self, forKey: .{{ codableProperty.name }}){%
            endif %}{% endfor %}
            if try container.decode(String.self, forKey: .type) != type {
                throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Not matching \(type)")
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self){%
            for codableProperty in codableProperties %}{%
            if codableProperty.optional %}
            try container.encodeIfPresent({{ codableProperty.name }}, forKey: .{{ codableProperty.name }}){%
            else %}
            try container.encode({{ codableProperty.name }}, forKey: .{{ codableProperty.name }}){%
            endif %}{% endfor %}
        }

        private enum CodingKeys: String, CodingKey {
            {% for codingKey in codingKeys %}
            case {{ codingKey }}{%
            endfor %}
        }
        {% endif %}
        {% if subSchemas.count > 0 %}
            {% for subSchema in subSchemas %}

                {{ subSchema|indent }}
            {% endfor %}
        {% endif %}
    }
    """#
    private let environment = Environment(loader: DictionaryLoader(templates: [
        "constantTemplate": constantTemplate,
        "objectTemplate": objectTemplate
    ]), extensions: StencilSwiftKit.stencilSwiftEnvironment().extensions)

    private func objectContext(for objectSchema: ObjectSchema, in environment: Environment, includesFixUps: [String] = []) -> [String: Any] {
        let sortedProperties = objectSchema.properties.sorted { $0.key < $1.key }
        let hasAttributes = objectSchema.attributes?.properties != nil
        let hasRelationships = objectSchema.subSchemas.contains(where: { if case .relationships = $0 { return true } else { return false } })
        let attributesOptional = !objectSchema.requiredProperties.contains("attributes")
        let relationshipsOptional = !objectSchema.requiredProperties.contains("relationships")
        var initParameters = sortedProperties.filter { $0.key != "type" }
        var codingKeys = sortedProperties.map(\.key)
        var codableProperties = initParameters.map { property in CodableProperty(name: property.key,
                                                                                 type: property.value.description,
                                                                                 optional: false) }
        if hasAttributes {
            let name = "attributes"
            let type = "Attributes"
            initParameters.append((key: name, value: PropertyType.schemaRef(type)))
            codingKeys.append(name)
            codableProperties.append(CodableProperty(name: name, type: type, optional: attributesOptional))
        }
        if hasRelationships {
            let name = "relationships"
            let type = "Relationships"
            initParameters.append((key: name, value: PropertyType.schemaRef(type)))
            codingKeys.append(name)
            codableProperties.append(CodableProperty(name: name, type: type, optional: relationshipsOptional))
        }
        let publicInit = initParameters
            .map {
                let propertyName = PropertyName(idealName: $0.key)
                var parameter = "\(propertyName.idealName)"
                if propertyName.hasDifferentSafeName {
                    parameter += " \(propertyName.safeName)"
                }
                parameter += ": \($0.value.description.capitalizingFirstLetter())"
                guard !objectSchema.requiredProperties.contains($0.key) else { return parameter }
                return "\(parameter)? = nil"
            }
            .joined(separator: ", ")
        return ["name": objectSchema.name,
                "isRequest": objectSchema.name.hasSuffix("Request"),
                "sortedProperties": sortedProperties,
                "properties": sortedProperties.map { property -> String in
                    switch property.value {
                    case .constant(let value):
                        return try! environment.renderTemplate(name: "constantTemplate", context: ["id": property.key, "value": value])
                    default:
                        return try! PropertyRenderer().render(id: property.key,
                                                              type: property.value.description,
                                                              optional: !objectSchema.requiredProperties.contains(property.key))
                    }
                },
                "publicInit": publicInit,
                "propertyNames": initParameters.map { PropertyName(idealName: $0.key) },
                "needsCustomCoding": sortedProperties.contains(where: { $0.key == "type" }),
                "codingKeys": codingKeys,
                "codableProperties": codableProperties,
                "attributes": objectSchema.attributes?.properties.sorted(by: { $0.key < $1.key }).map { property in
                    try! PropertyRenderer().render(id: property.key,
                                                   type: property.value.description,
                                                   optional: !objectSchema.requiredProperties.contains(property.key))
                } ?? [],
                "attributesOptional": attributesOptional,
                "hasRelationships": hasRelationships,
                "relationshipsOptional": relationshipsOptional,
                "subSchemas": objectSchema.subSchemas.sorted(by: { $0.name < $1.name }).map { subSchema -> String in
                    switch subSchema {
                    case .objectSchema(let objectSchema):
                        return try! render(objectSchema: objectSchema)
                    case .enumSchema(let enumSchema):
                        return try! EnumSchemaRenderer().render(enumSchema: enumSchema)
                    case .oneOf(let name, let oneOfSchema):
                        return try! OneOfSchemaRenderer().render(name: name, oneOfSchema: oneOfSchema, includesFixUps: includesFixUps)
                    case .attributes(let attributesSchema):
                        return try! AttributesSchemaRenderer().render(attributesSchema: attributesSchema)
                    case .relationships(let objectSchema):
                        return try! render(objectSchema: objectSchema)
                    }

        }]
    }

    private struct PropertyName {
        let idealName: String
        let safeName: String
        var hasDifferentSafeName: Bool { idealName != safeName }

        init(idealName: String) {
            self.idealName = idealName
            self.safeName = idealName == "self" ? "aSelf" : idealName
        }
    }
    
    private struct CodableProperty {
        let name: String
        let type: String
        let optional: Bool
    }
}
