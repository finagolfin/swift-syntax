//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public let TYPE_NODES: [Node] = [
  Node(
    kind: .arrayType,
    base: .type,
    nameForDiagnostics: "array type",
    children: [
      Child(
        name: "leftSquare",
        deprecatedName: "leftSquareBracket",
        kind: .token(choices: [.token(.leftSquare)])
      ),
      Child(
        name: "element",
        deprecatedName: "elementType",
        kind: .node(kind: .type)
      ),
      Child(
        name: "rightSquare",
        deprecatedName: "rightSquareBracket",
        kind: .token(choices: [.token(.rightSquare)])
      ),
    ]
  ),

  Node(
    kind: .attributedType,
    base: .type,
    nameForDiagnostics: "type",
    traits: [
      "WithAttributes"
    ],
    children: [
      Child(
        name: "specifier",
        kind: .token(choices: [
          .keyword(.inout),
          .keyword(.__shared),
          .keyword(.__owned),
          .keyword(.isolated),
          .keyword(._const),
          .keyword(.borrowing),
          .keyword(.consuming),
          .keyword(.transferring),
          .keyword(._resultDependsOn),
        ]),
        isOptional: true
      ),
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true)
      ),
      Child(
        name: "baseType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .classRestrictionType,
    base: .type,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "classKeyword",
        kind: .token(choices: [.keyword(.class)])
      )
    ]
  ),

  Node(
    kind: .compositionTypeElementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.compositionTypeElement]
  ),

  Node(
    kind: .compositionTypeElement,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "type",
        kind: .node(kind: .type)
      ),
      Child(
        name: "ampersand",
        kind: .node(kind: .token),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .compositionType,
    base: .type,
    nameForDiagnostics: "type composition",
    children: [
      Child(
        name: "elements",
        kind: .collection(kind: .compositionTypeElementList, collectionElementName: "Element")
      )
    ]
  ),

  Node(
    kind: .someOrAnyType,
    base: .type,
    nameForDiagnostics: "type",
    children: [
      Child(
        name: "someOrAnySpecifier",
        kind: .token(choices: [.keyword(.some), .keyword(.any)])
      ),
      Child(
        name: "constraint",
        deprecatedName: "baseType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .dictionaryType,
    base: .type,
    nameForDiagnostics: "dictionary type",
    children: [
      Child(
        name: "leftSquare",
        deprecatedName: "leftSquareBracket",
        kind: .token(choices: [.token(.leftSquare)])
      ),
      Child(
        name: "key",
        deprecatedName: "keyType",
        kind: .node(kind: .type),
        nameForDiagnostics: "key type"
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "value",
        deprecatedName: "valueType",
        kind: .node(kind: .type),
        nameForDiagnostics: "value type"
      ),
      Child(
        name: "rightSquare",
        deprecatedName: "rightSquareBracket",
        kind: .token(choices: [.token(.rightSquare)])
      ),
    ]
  ),

  Node(
    kind: .functionType,
    base: .type,
    nameForDiagnostics: "function type",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "parameters",
        deprecatedName: "arguments",
        kind: .collection(kind: .tupleTypeElementList, collectionElementName: "Parameter", deprecatedCollectionElementName: "Argument")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
      Child(
        name: "effectSpecifiers",
        kind: .node(kind: .typeEffectSpecifiers),
        isOptional: true
      ),
      Child(
        name: "returnClause",
        deprecatedName: "output",
        kind: .node(kind: .returnClause)
      ),
    ]
  ),

  Node(
    kind: .genericArgumentClause,
    base: .syntax,
    nameForDiagnostics: "generic argument clause",
    children: [
      Child(
        name: "leftAngle",
        deprecatedName: "leftAngleBracket",
        kind: .token(choices: [.token(.leftAngle)])
      ),
      Child(
        name: "arguments",
        kind: .collection(kind: .genericArgumentList, collectionElementName: "Argument")
      ),
      Child(
        name: "rightAngle",
        deprecatedName: "rightAngleBracket",
        kind: .token(choices: [.token(.rightAngle)])
      ),
    ]
  ),

  Node(
    kind: .genericArgumentList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.genericArgument]
  ),

  Node(
    kind: .genericArgument,
    base: .syntax,
    nameForDiagnostics: "generic argument",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "argument",
        deprecatedName: "argumentType",
        kind: .node(kind: .type)
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .implicitlyUnwrappedOptionalType,
    base: .type,
    nameForDiagnostics: "implicitly unwrapped optional type",
    children: [
      Child(
        name: "wrappedType",
        kind: .node(kind: .type)
      ),
      Child(
        name: "exclamationMark",
        kind: .token(choices: [.token(.exclamationMark)])
      ),
    ]
  ),

  Node(
    kind: .memberType,
    base: .type,
    nameForDiagnostics: "member type",
    children: [
      Child(
        name: "baseType",
        kind: .node(kind: .type),
        nameForDiagnostics: "base type"
      ),
      Child(
        name: "period",
        kind: .token(choices: [.token(.period)])
      ),
      Child(
        name: "name",
        kind: .token(choices: [.token(.identifier), .keyword(.self)]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "genericArgumentClause",
        kind: .node(kind: .genericArgumentClause),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .metatypeType,
    base: .type,
    nameForDiagnostics: "metatype",
    children: [
      Child(
        name: "baseType",
        kind: .node(kind: .type),
        nameForDiagnostics: "base type"
      ),
      Child(
        name: "period",
        kind: .token(choices: [.token(.period)])
      ),
      Child(
        name: "metatypeSpecifier",
        deprecatedName: "typeOrProtocol",
        kind: .token(choices: [.keyword(.Type), .keyword(.Protocol)])
      ),
    ]
  ),

  Node(
    kind: .namedOpaqueReturnType,
    base: .type,
    nameForDiagnostics: "named opaque return type",
    children: [
      Child(
        name: "genericParameterClause",
        deprecatedName: "genericParameters",
        kind: .node(kind: .genericParameterClause),
        documentation: "The parameter clause that defines the generic parameters."
      ),
      Child(
        name: "type",
        deprecatedName: "baseType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .optionalType,
    base: .type,
    nameForDiagnostics: "optional type",
    children: [
      Child(
        name: "wrappedType",
        kind: .node(kind: .type)
      ),
      Child(
        name: "questionMark",
        kind: .token(choices: [.token(.postfixQuestionMark)])
      ),
    ]
  ),

  Node(
    kind: .suppressedType,
    base: .type,
    nameForDiagnostics: "suppressed type conformance",
    children: [
      Child(
        name: "withoutTilde",
        kind: .token(choices: [.token(.prefixOperator)])
      ),
      Child(
        name: "type",
        deprecatedName: "patternType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .packExpansionType,
    base: .type,
    nameForDiagnostics: "variadic expansion",
    children: [
      Child(
        name: "repeatKeyword",
        kind: .token(choices: [.keyword(.repeat)])
      ),
      Child(
        name: "repetitionPattern",
        deprecatedName: "patternType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .packElementType,
    base: .type,
    nameForDiagnostics: "pack element",
    children: [
      Child(
        name: "eachKeyword",
        kind: .token(choices: [.keyword(.each)])
      ),
      Child(
        name: "pack",
        deprecatedName: "packType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .identifierType,
    base: .type,
    nameForDiagnostics: "type",
    children: [
      Child(
        name: "name",
        kind: .token(choices: [
          .token(.identifier),
          .keyword(.Self),
          .keyword(.Any),
          .token(.wildcard),
        ])
      ),
      Child(
        name: "genericArgumentClause",
        kind: .node(kind: .genericArgumentClause),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .tupleTypeElementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.tupleTypeElement]
  ),

  Node(
    kind: .tupleTypeElement,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "inoutKeyword",
        deprecatedName: "inOut",
        kind: .token(choices: [.keyword(.inout)]),
        isOptional: true
      ),
      Child(
        name: "firstName",
        deprecatedName: "name",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)]),
        nameForDiagnostics: "name",
        isOptional: true
      ),
      Child(
        name: "secondName",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)]),
        nameForDiagnostics: "internal name",
        isOptional: true
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        isOptional: true
      ),
      Child(
        name: "type",
        kind: .node(kind: .type)
      ),
      Child(
        name: "ellipsis",
        kind: .token(choices: [.token(.ellipsis)]),
        isOptional: true
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .tupleType,
    base: .type,
    nameForDiagnostics: "tuple type",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "elements",
        kind: .collection(kind: .tupleTypeElementList, collectionElementName: "Element")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

]
