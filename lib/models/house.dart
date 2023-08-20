class House {
  String name;
  String address;
  String imageUrl;

  House(this.name, this.address, this.imageUrl);

  static List<House> generateRecommended() {
    return [
      House('La Martinica', '#42-34, Torre 2, Plazuela alm',
          'assets/images/house01.jpeg'),
      House('Habitacion Moon House', 'P455, Chhatak, Sylhet',
          'assets/images/house02.jpeg'),
    ];
  }

  static List<House> generateBestOffer() {
    return [
      House('Estrella', 'call 3 #134, Americas',
          'assets/images/offer01.jpeg'),
      House('Habitación amoblada', 'calle 2, Cariongo',
          'assets/images/offer02.jpeg'),
    ];
  }
}
