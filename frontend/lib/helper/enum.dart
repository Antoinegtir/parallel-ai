enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

enum PostType {
  Post,
  Detail,
  Reply,
  ParentPost,
}

enum SortUser {
  Verified,
  Alphabetically,
  Newest,
  Oldest,
  MaxFollower,
}

enum NotificationType {
  NOT_DETERMINED,
  Message,
  Post,
  Reply,
  RePost,
  Follow,
  Mention,
  Like
}
