class MusicMetadataEntity {
  String artistName;
  String trackName;
  String collectionName;
  String artworkUrl100;

  MusicMetadataEntity(
      this.artistName, this.trackName, this.collectionName, this.artworkUrl100);

  factory MusicMetadataEntity.fromJson(Map<String, dynamic> json) {
    return MusicMetadataEntity(
      json['artistName'],
      json['trackName'],
      json['collectionName'],
      json['artworkUrl100'],
    );
  }
}
