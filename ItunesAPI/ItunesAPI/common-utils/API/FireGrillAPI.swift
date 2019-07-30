////
////  HomeViewController.swift
////  ItunesAPI
////
////  Created by Albert on 30/07/2019.
////  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
////
//
//import UIKit
//import Moya
//import Alamofire
//import GoogleMaps
//
//
//// MARK: - Provider setup
//
//let manager: Manager = {
//    
//    let serverTrustPolicies: [String: ServerTrustPolicy] = [
//        serviceURL: .disableEvaluation
//    ]
//    
//    let configuration = URLSessionConfiguration.default
//    configuration.timeoutIntervalForRequest = 240
//    configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
//    
//    switch environment {
//    case .development:
//        return Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
//    case .production:
//        return Manager(configuration: configuration, serverTrustPolicyManager: nil)
//    }
//}()
//
//let endpointClosure = { (target: Itunes) -> Endpoint in
//    let endpoint: Endpoint = Endpoint(url: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
//    
//    return endpoint
//}
//
//var ItunesProvider: MoyaProvider<Itunes> = {
//    switch environment {
//    case .development, .production:
//        let networkLogger = NetworkLoggerPlugin(verbose: true, responseDataFormatter: nil)
//        return MoyaProvider<Itunes>(endpointClosure: endpointClosure,
//                                    manager: manager,
//                                    plugins:[networkLogger])
////    case .production:
////        return MoyaProvider<Itunes>(endpointClosure: endpointClosure, manager: manager)
//    }
//}()
//
//
//private func JSONResponseDataFormatter(_ data: Data) -> Data {
//    do {
//        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
//        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
//        return prettyData
//    } catch {
//        return data // fallback to original data if it can't be serialized.
//    }
//}
//
//// MARK: - Provider support
//
//extension String {
//    var urlEscaped: String {
//        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
//    }
//}
//
//public enum Itunes {
//    case searctItem(String)
//}
//
//extension Itunes: TargetType {
//    public var baseURL: URL {
//        return URL(string: "https://itunes.apple.com")!
//    }
//    public var path: String {
//        switch self {
//            case .searctItem(let item)
//            return "/search?term=\(item)&country=au&media=movie&all"
//        }
//    }
//    
//    public var method: Moya.Method {
//        switch self {
//        case .login, .register, .socialLogin, .forgotPassword, .verifyUser, .resendSMS, .uploadImage, .sendFeedBack, .addFavorites, .requestPayfortToken, .createOrder, .upsell, .cancelOrder, .registerAsGuest, .registerDevice, .addCustomerAddress:
//            return .post
//        case .addMobileNumber, .updateDetails, .changeLanguage:
//            return .patch
//        case .deleteFavorites:
//            return .delete
//        default:
//            return .get
//        }
//    }
//    
//    public var parameters: [String: Any]? {
//        switch self {
//        case .login(let email, let password):
//            return ["username": email, "password": password]
//        case .forgotPassword(let email):
//            return ["username": email]
//        case .socialLogin(let accessToken, let provider, let secret):
//            if provider.rawValue == 2 {
//                return ["provider": provider.rawValue, "token": accessToken, "secret": secret]
//            }
//            return ["provider": provider.rawValue, "token": accessToken]
//        case .register(let registrationData):
//            return ["first-name": registrationData.firstName, "last-name": registrationData.lastName, "email": registrationData.email, "password": registrationData.password, "username": registrationData.email, "mobile": registrationData.mobileNo, "account-type": registrationData.accountType, "status": registrationData.status]
//        case .registerAsGuest(let registrationData):
//            return ["first-name": registrationData.firstName, "last-name": registrationData.lastName, "password": registrationData.password, "username": registrationData.mobileNo, "mobile": registrationData.mobileNo, "account-type": registrationData.accountType, "status": registrationData.status]
//        case .addMobileNumber(_, let mobileNumber):
//            return ["mobile": mobileNumber]
//        case .updateDetails(_, let registrationData):
//            if registrationData.password.isEmpty {
//                return ["first-name": registrationData.firstName, "last-name": registrationData.lastName, "email": registrationData.email, "username": registrationData.email, "mobile": registrationData.mobileNo]
//            }
//            return ["first-name": registrationData.firstName, "last-name": registrationData.lastName, "email": registrationData.email, "username": registrationData.email, "mobile": registrationData.mobileNo, "password": registrationData.password]
//        case .verifyUser(_, let pinCode):
//            return ["pincode": pinCode]
//        case .resendSMS(let id, let mobileNumber):
//            return ["id": id, "mobile": mobileNumber]
//        case .sendFeedBack(let feedBack, let imgUrl):
//            return ["name": feedBack.name, "telephone": feedBack.mobile, "email": feedBack.email, "subject": feedBack.comment, "body": feedBack.comment, "image": imgUrl]
//        case .addFavorites(_, let itemId):
//            return ["item-id": itemId]
//        case .requestPayfortToken:
//            let deviceId = UIDevice.current.identifierForVendor!.uuidString
//            return ["device-id": deviceId, "lang": "en"]
//        case .createOrder(let orderDetails):
//            guard let payment = orderDetails.payment else {
//                return ["customer": orderDetails.customer, "address": orderDetails.address, "location": orderDetails.location, "source": orderDetails.source, "type": orderDetails.type, "total": orderDetails.total, "subtotal": orderDetails.subtotal, "delivery-charge": orderDetails.deliveryCharge, "discount": orderDetails.discount, "coupon-code": orderDetails.couponCode, "scheduled-time": orderDetails.scheduledTime, "points": orderDetails.points, "total-points": orderDetails.totalPoints, "mobile": orderDetails.mobile, "items": codableEncoder(someT: orderDetails.items)!]
//            }
//            return ["customer": orderDetails.customer, "address": orderDetails.address, "location": orderDetails.location, "source": orderDetails.source, "type": orderDetails.type, "total": orderDetails.total, "subtotal": orderDetails.subtotal, "vat-amount": orderDetails.vatAmount, "delivery-charge": orderDetails.deliveryCharge, "discount": orderDetails.discount, "coupon-code": orderDetails.couponCode, "scheduled-time": orderDetails.scheduledTime, "points": orderDetails.points, "total-points": orderDetails.totalPoints, "mobile": orderDetails.mobile, "payment": codableEncoder(someT: payment)!, "items": codableEncoder(someT: orderDetails.items)!]
//        case .upsell(_, let upSell):
//            return ["value": upSell.value, "items": codableEncoder(someT: upSell.items)!]
//        case .cancelOrder:
//            return ["order-status": "cancelled-by-customer"]
//        case .registerDevice(let deviceToken, let customerId):
//            let deviceId = UIDevice.current.identifierForVendor!.uuidString
//            return ["token": deviceToken, "device-id": deviceId, "customer-id": customerId, "type": "customer"]
//        case .changeLanguage(_):
//            let acceptLanguage = Translator.currentAppleLanguage() == "ar" ? "ar-sa" : "en-us"
//            return ["current-language": acceptLanguage]
//        case .addCustomerAddress(_, let customerAddress):
//            return ["created-at": customerAddress.createdAt, "label": customerAddress.label, "country": customerAddress.country, "post-code": customerAddress.postCode, "state": customerAddress.state, "city": customerAddress.city, "line2": customerAddress.line2, "line1": customerAddress.line1, "lat": Double(round(10000 * customerAddress.lat) / 10000), "long": Double(round(10000 * customerAddress.long) / 10000), "telephone": customerAddress.telephone, "instructions": customerAddress.instructions, "photo-uri": customerAddress.photoUri]
//        default:
//            return nil
//        }
//    }
//    
//    public var parameterEncoding: ParameterEncoding {
//        return JSONEncoding.default
//    }
//    
//    public var task: Task {
//        switch self {
//        case .login, .forgotPassword, .register, .socialLogin, .addMobileNumber, .verifyUser, .updateDetails, .resendSMS, .sendFeedBack, .addFavorites, .requestPayfortToken, .createOrder, .upsell, .cancelOrder, .registerAsGuest, .registerDevice, .changeLanguage, .addCustomerAddress:
//            return .requestParameters(parameters: self.parameters!, encoding: self.parameterEncoding)
//        case .uploadImage(let imgData):
//            let imageMultipartFormData = MultipartFormData(provider: .data(imgData), name: "feedBack", fileName: "feedBack", mimeType: "image/jpg")
//            
//            let imageTypeData = MultipartFormData(provider: .data("feedback".data(using: .utf8)!), name: "image_type")
//            let multipartData = [imageMultipartFormData, imageTypeData]
//            
//            return .uploadMultipart(multipartData)
//        default:
//            return .requestPlain
//        }
//    }
//    
//    public var sampleData: Data {
//        return Data()
//    }
//    
//    public var headers: [String: String]? {
//        let acceptLanguage = Translator.currentAppleLanguage() == "ar" ? "ar-sa" : "en-us"
//        let soloConcept = environment == .development ? "Cw4CCgoMDQg" : "14"
//        switch self {
//        case .login, .register, .socialLogin, .forgotPassword, .verifyUser, .resendSMS, .getStores, .uploadImage, .registerAsGuest:
//            return ["Content-Type": "application/json", "Solo-Concept": soloConcept, "Accept-Language": acceptLanguage]
//        case .getCustomerDetails, .updateDetails, .sendFeedBack, .addFavorites, .getFavorites, .deleteFavorites, .subCategories, .itemModifiers, .getItem, .upsellItems, .createOrder, .upsell, .orderStatus, .orderHistory, .cancelOrder, .getOrderItems, .addMobileNumber, .registerDevice, .changeLanguage, .addCustomerAddress, .getCustomerAddresses, .getNearestBranch, .getDeliveryAddressBreakfast:
//            let keychainManager = KeychainAccessManager()
//            let accessToken = keychainManager.getAccessToken()
//            if accessToken.isEmpty {
//                return ["Content-Type": "application/json", "Solo-Concept": soloConcept, "Accept-Language": acceptLanguage]
//            }
//            return ["Content-Type": "application/json", "Solo-Concept": soloConcept, "Authorization": "Bearer " + accessToken, "Accept-Language": acceptLanguage]
//        default:
//            return ["Content-Type": "application/json", "Solo-Concept": soloConcept, "Accept-Language": acceptLanguage]
//        }
//    }
//    
//    func codableEncoder<T: Codable>(someT: T) -> Any? {
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//        let data = try! encoder.encode(someT)
//        let jsonArray = try? JSONSerialization.jsonObject(with: data, options:[])
//        return jsonArray
//    }
//}
//
//public func url(_ route: TargetType) -> String {
//    return route.baseURL.appendingPathComponent(route.path).absoluteString.removingPercentEncoding!
//}
