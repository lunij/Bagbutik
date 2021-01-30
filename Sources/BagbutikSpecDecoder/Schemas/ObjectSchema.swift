import Foundation

public struct ObjectSchema: Decodable {
    public let type: String
    public let properties: [String: PropertyType]
    public let requiredProperties: [String]
    public let name: String
    public let attributes: AttributesSchema?
    public let subSchemas: [SubSchema]

    enum CodingKeys: String, CodingKey {
        case type
        case title
        case properties
        case required
        case attributes
        case relationships
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        requiredProperties = try container.decodeIfPresent([String].self, forKey: .required) ?? []
        let propertiesContainer = try container.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: .properties)
        var subSchemas = [SubSchema]()
        properties = try propertiesContainer.allKeys.reduce(into: [String: PropertyType]()) { properties, key in
            guard key.stringValue != CodingKeys.attributes.stringValue,
                key.stringValue != CodingKeys.relationships.stringValue else { return }
            guard let propertyType = try? propertiesContainer.decode(PropertyType.self, forKey: key) else {
                throw DecodingError.dataCorruptedError(forKey: key, in: propertiesContainer, debugDescription: "Property type not known")
            }
            switch propertyType {
            case .arrayOfSubSchema(let schema):
                subSchemas.append(.objectSchema(schema))
            case .oneOf(let name, let schema):
                subSchemas.append(.oneOf(name: name, schema: schema))
            case .arrayOfOneOf(let name, let schema):
                subSchemas.append(.oneOf(name: name, schema: schema))
            case .schema(let schema):
                subSchemas.append(.objectSchema(schema))
            case .enumSchema(let schema):
                subSchemas.append(.enumSchema(schema))
            default: break
            }
            properties[key.stringValue] = propertyType
        }
        name = try container.decodeIfPresent(String.self, forKey: .title) ?? container.codingPath.last { $0.stringValue != "items" }!.stringValue
        attributes = try propertiesContainer.decodeIfPresent(AttributesSchema.self, forKey: DynamicCodingKeys(stringValue: "attributes")!)
        if let attributes = attributes, attributes.properties.count > 0 {
            subSchemas.append(.attributes(attributes))
        }
        if let relationships = try propertiesContainer.decodeIfPresent(ObjectSchema.self, forKey: DynamicCodingKeys(stringValue: "relationships")!),
            relationships.properties.count > 0 {
            subSchemas.append(.relationships(relationships))
        }
        self.subSchemas = subSchemas
    }
}
