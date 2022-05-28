//  UserModel.swift
//
//  Created by Jesteena on 28/05/22.
//
struct UserModel: Decodable {

     let name: String?
     let username: String?
     let email: String?
     let profile_image: String?
     let company: CompanyModel?
     let phone: String?
     let website: String?
     let address: AddressModel?

  

}

struct CompanyModel: Decodable {

     let name: String?
     let catchPhrase: String?
     let bs: String?

}

struct AddressModel: Decodable {

     let street: String?
     let suite: String?
     let city: String?
     let zipcode: String?
     let geo: GeoModel?

}
struct GeoModel: Decodable {

     let lat: String?
     let lng: String?

}
