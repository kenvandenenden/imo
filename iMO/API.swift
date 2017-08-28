//  This file was automatically generated and should not be edited.

import Apollo

public final class WorkRecommendationsQuery: GraphQLQuery {
  public static let operationString =
    "query WorkRecommendations($id: ID!, $limit: Int) {" +
    "  work(id: $id) {" +
    "    __typename" +
    "    recommendations(limit: $limit) {" +
    "      __typename" +
    "      work {" +
    "        __typename" +
    "        id" +
    "        title" +
    "        image {" +
    "          __typename" +
    "          link(width: 750, height: 750)" +
    "        }" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public var id: GraphQLID
  public var limit: Int?

  public init(id: GraphQLID, limit: Int? = nil) {
    self.id = id
    self.limit = limit
  }

  public var variables: GraphQLMap? {
    return ["id": id, "limit": limit]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("work", arguments: ["id": Variable("id")], type: .object(Work.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(work: Work? = nil) {
      self.init(snapshot: ["__typename": "Query", "work": work])
    }

    /// A work
    public var work: Work? {
      get {
        return (snapshot["work"]! as! Snapshot?).flatMap { Work(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "work")
      }
    }

    public struct Work: GraphQLSelectionSet {
      public static let possibleTypes = ["Work"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("recommendations", arguments: ["limit": Variable("limit")], type: .list(.object(Recommendation.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(recommendations: [Recommendation?]? = nil) {
        self.init(snapshot: ["__typename": "Work", "recommendations": recommendations])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Recommendations for this work
      public var recommendations: [Recommendation?]? {
        get {
          return (snapshot["recommendations"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Recommendation(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "recommendations")
        }
      }

      public struct Recommendation: GraphQLSelectionSet {
        public static let possibleTypes = ["Recommendation"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("work", type: .object(Work.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(work: Work? = nil) {
          self.init(snapshot: ["__typename": "Recommendation", "work": work])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var work: Work? {
          get {
            return (snapshot["work"]! as! Snapshot?).flatMap { Work(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "work")
          }
        }

        public struct Work: GraphQLSelectionSet {
          public static let possibleTypes = ["Work"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(GraphQLID.self)),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("image", type: .nonNull(.object(Image.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(id: GraphQLID? = nil, title: String, image: Image) {
            self.init(snapshot: ["__typename": "Work", "id": id, "title": title, "image": image])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID? {
            get {
              return snapshot["id"]! as! GraphQLID?
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          /// The title
          public var title: String {
            get {
              return snapshot["title"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "title")
            }
          }

          /// The work image
          public var image: Image {
            get {
              return Image(snapshot: snapshot["image"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "image")
            }
          }

          public struct Image: GraphQLSelectionSet {
            public static let possibleTypes = ["Image"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("link", arguments: ["width": 750, "height": 750], type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(link: String) {
              self.init(snapshot: ["__typename": "Image", "link": link])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Link to the image on imagehaus
            public var link: String {
              get {
                return snapshot["link"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "link")
              }
            }
          }
        }
      }
    }
  }
}

public final class WorksQuery: GraphQLQuery {
  public static let operationString =
    "query Works($ids: [ID!]!) {" +
    "  works(ids: $ids) {" +
    "    __typename" +
    "    works {" +
    "      __typename" +
    "      id" +
    "      title" +
    "      image {" +
    "        __typename" +
    "        link(width: 750, height: 750)" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public var ids: [GraphQLID]

  public init(ids: [GraphQLID]) {
    self.ids = ids
  }

  public var variables: GraphQLMap? {
    return ["ids": ids]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("works", arguments: ["ids": Variable("ids")], type: .object(Work.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(works: Work? = nil) {
      self.init(snapshot: ["__typename": "Query", "works": works])
    }

    /// A set of works
    public var works: Work? {
      get {
        return (snapshot["works"]! as! Snapshot?).flatMap { Work(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "works")
      }
    }

    public struct Work: GraphQLSelectionSet {
      public static let possibleTypes = ["WorkSet"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("works", type: .list(.object(Work.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(works: [Work?]? = nil) {
        self.init(snapshot: ["__typename": "WorkSet", "works": works])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var works: [Work?]? {
        get {
          return (snapshot["works"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Work(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "works")
        }
      }

      public struct Work: GraphQLSelectionSet {
        public static let possibleTypes = ["Work"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(GraphQLID.self)),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("image", type: .nonNull(.object(Image.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: GraphQLID? = nil, title: String, image: Image) {
          self.init(snapshot: ["__typename": "Work", "id": id, "title": title, "image": image])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID? {
          get {
            return snapshot["id"]! as! GraphQLID?
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        /// The title
        public var title: String {
          get {
            return snapshot["title"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "title")
          }
        }

        /// The work image
        public var image: Image {
          get {
            return Image(snapshot: snapshot["image"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "image")
          }
        }

        public struct Image: GraphQLSelectionSet {
          public static let possibleTypes = ["Image"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("link", arguments: ["width": 750, "height": 750], type: .nonNull(.scalar(String.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(link: String) {
            self.init(snapshot: ["__typename": "Image", "link": link])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Link to the image on imagehaus
          public var link: String {
            get {
              return snapshot["link"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "link")
            }
          }
        }
      }
    }
  }
}