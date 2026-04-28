//
//  Theme.swift
//  Volttic
//
//  Created by ShwetJ on 11/12/22.
//

import Foundation
import SwiftUI
import UIKit
struct Theme {
    //let deeplinkSchema: String = "PhonePeExampleScheme" //YOUR CUSTOM UNIQUE DEEPLINK SCHEMA
    static let mapMarker = UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1.0)
    static let primaryUI = UIColor(red: 46/255.0, green: 158/255.0, blue: 250/255.0, alpha: 1.0)
    static let AppBGUI = UIColor(red: 250/255.0, green: 250/255.0, blue: 238/255.0, alpha: 1.0)
    static let offline = UIColor(red: 204/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
    static let availabe = UIColor(red: 0/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
    static let busy = UIColor(red: 255/255.0, green: 102/255.0, blue: 0/255.0, alpha: 1.0)
    static let duskYelo = UIColor(red: 255/255.0, green: 222/255.0, blue: 46/255.0, alpha: 1.0)
    static let gray = UIColor(red: 229/255.0, green: 229/255.0, blue: 240/255.0, alpha: 1.0)
    static let grayUI = UIColor(red: 88/255.0, green: 88/255.0, blue: 88/255.0, alpha: 1.0)
    static let environmentGrren = UIColor(red: 0/255.0, green: 108/255.0, blue: 75/255.0, alpha: 1.0)
    static let dateTimeNow = Date()
    static let DeviceType = "IOS"
    static let AppBG = Color("App_BG")
    static let ColorAccent = Color("ColorAccent")
    static let Cs_busy_bg = Color("Cs_busy_bg")
    static let appName = "BEL"
    static let Cs_offline_bg = Color("Cs_offline_bg")
    static let txtBackground = Color("TxtBackground")
    static let Csavailablebg = Color("Csavailablebg")
    static let DuskYellow = Color("DuskYellow")
    static let LightGray = Color("LightGray")
    static let OffGray = Color("OffGray")
    static let Primary = Color("Primary")
    static let Purpel_200 = Color("Purpel_200")
    static let Purpel_500 = Color("Purpel_500")
    static let Purpel_700 = Color("Purpel_700")
    static let EnvironmentIg = Color("EnvironmentIg")
    static let Cs_offline_text_color = Color("Cs_offline_text_color")
    static let Cs_available_text_color = Color("Cs_available_text_color")
    static let Ss_busy_text_color = Color("Ss_busy_text_color")
    static let TextGray = Color("TextGray")
    static let VoltticColor = Color("VoltticColor")
    static let mobileNumberColor = Color("MobileNumberColor")
    static let textGray = Color("TextGray")
    static let grayColor = Color("Gray")
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let noInternet =  "Internet connection is not available" 
    static let rupee =  "\u{20B9}" 
    static let punchLine = "Enjoy Elegant EV Charging Services"
    static let baseUrl = "https://belevcharger.co.in/bel/webservice/iosservice"
    static let reservationBaseUrl = "https://belevcharger.co.in/bel/webservice/reservationservice"
    static let cpoBaseUrl = "https://belevcharger.co.in/bel/webservice/CPOServices"
    static let ocppBaseUrl = "https://belevcharger.co.in/bel/webservice/OCPPService"

    static let liveMoniterBaseUrl = "https://belevcharger.co.in/bel/webservice/LiveMonitoringService"
                    
    //"https://volttic.in/cms/webservice/iosservice"
    static let chargingHistoryInvoice = "https://belevcharger.co.in/bel/webservice/iosservice/TransactionInvoice?argument-1="
    static let chargingHistoryInvoiceCpo = "https://belevcharger.co.in/bel/webservice/iosservice/TransactionInvoiceCPO?argument-1="
    static let stationImageBaseUrl = "https://belevcharger.co.in/bel/webservice/iosservice/getChargingStationImage?argument-1="
    //"https://volttic.co.in/cms/webservice/mobileApp/"
//https://volttic.co.in/cms/webservice/googleMaps/all
    static let googleApiBaseUrl = "https://belevcharger.co.in/bel/webservice/googleMaps/"
    static let allStationBaseUrl = "https://belevcharger.co.in/bel/webservice/googleMaps/all"
    
//    static let googleApiBaseUrl = "https://volttic.in/cms/webservice/googleMaps/"
//    static let allStationBaseUrl = "https://volttic.in/cms/webservice/googleMaps/all"
    static let MIDPT = "SWNWdV11638876233030"
    static let paytmCallback = "https://secureg w-stage.paytm.in/theia/paytmCallback"
    static let phonpeCallback = "https://webhook.site/callback-url"
    static let phonePeStatusUrl = "https://api-preprod.phonepe.com/apis/merchant-simulator/pg/v1/status/"
    static let aboutusUrl = "https://belevcharger.co.in/bel/app_about_us.jsp"
    static let voltticPrivacyPolicyUrl = "https://belevcharger.co.in/bel/app_privacy_policy.jsp"
    static func navigationBarColors(background : UIColor?,
           titleColor : UIColor? = nil, tintColor : UIColor? = nil ){
            
            let navigationAppearance = UINavigationBarAppearance()
            navigationAppearance.configureWithOpaqueBackground()
            navigationAppearance.backgroundColor = background ?? .clear
            
            navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
            navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
           
            UINavigationBar.appearance().standardAppearance = navigationAppearance
            UINavigationBar.appearance().compactAppearance = navigationAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance

            UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
        }
}
struct ImageType{
    static let VoltticImg = "logo_volttic_dashboard"
}

struct Connector {
    static let initialize = "/initialize"
    static let aerifyMobileNumber = "/verifyMobileNumber"
    static let verifyOTP = "/verifyOTP"
    static let register = "/register"
    static let getAppVersionCode = "/getAppVersionCode"
    static let getProfile = "/getProfile"
    static let updateProfile =  "/updateProfile"
    static let authenticate = "/authenticate"
    
    static let getCustomerVehicles = "/getCustomerVehicles"
    static let getConnectorTypes = "/getConnectorTypes"
    static let getTodayTotal = "/getTodayTotal"
    static let getThisMonthTotal = "/getThisMonthTotal"
    static let getThisWeekTotal = "/getThisWeekTotal"
    
    static let getCPOTodayTotal = "/getCPOTodayTotal"
    static let getCPOThisMonthTotal = "/getCPOThisMonthTotal"
    static let getCPOThisWeekTotal = "/getCPOThisWeekTotal"
    
    static let getSlotsByConnectorCode = "/getSlotsByConnectorCode"
    static let getConnectorActualRatingByConnectorCode = "/getConnectorActualRatingByConnectorCode"
    static let addDriverSlotBooking = "/addDriverSlotBooking"
    static let addCustomerSlotBooking = "/addCustomerSlotBooking"
    static let addCPOSlotBooking = "/addCPOSlotBooking"
    static let updateSlot = "/updateSlot"
    static let updateSlotAvailable = "/updateSlotAvailable"
    static let getBookedSlots = "/getBookedSlots"
    static let cancelSlotBookingByApp = "/cancelSlotBookingByApp"
    static let getCPOByMobileNumber = "/getCPOByMobileNumber"
    static let getEnrollmentIds = "/getEnrollmentIds"
    static let getCPORegistrationRequestStatusByMobileNumber = "/getCPORegistrationRequestStatusByMobileNumber"
    static let addCPORegistrationRequest = "/addCPORegistrationRequest"
    static let deleteCPORegistrationRequest = "/deleteCPORegistrationRequest"
    static let getByPartnerCode = "/getByPartnerCode"
    
    
    static let getCarsRegistrationNumbers = "/getCarsRegistrationNumbers"
    static let VerifyMobileNumber = "/verifyMobileNumber"
    static let editCustomerVehicle = "/editCustomerVehicle"
    static let addCustomerVehicle = "/addCustomerVehicle"
    static let getVehicles = "/getVehicles"
    static let getWalletBalanceByCustomer = "/getWalletBalanceByCustomer"
    static let deleteCustomerVehicle = "/deleteCustomerVehicle"
    static let all = "Service/all"
    static let getLedger = "/getLedger"
    static let getAllTransactionHistoryByMobileNumber = "/getAllTransactionHistoryByMobileNumber"
    static let getThisMonthTransactionHistoryByMobileNumber = "/getThisMonthTransactionByMobileNumber"
    static let getThisYearTransactionHistoryByMobileNumber = "/getThisYearTransactionByMobileNumber"
   
    static let getIssueCategories = "/getIssueCategories"
    static let reportIssue = "/reportIssue"
    static let qrCode = "/qrCode"
    static let getFAQs = "/getFAQs"
    static let deleteAccount = "/deleteAccount"
    static let getLiveChargingSessions = "/getLiveChargingSessions"
    static let addPartnerDriverReceipt = "/addPartnerDriverReceipt"
    static let remoteStartTransaction = "/remoteStartTransaction"
    static let remoteStopTransaction = "/remoteStopTransaction"
    static let getChargingStatus = "/getChargingStatus"
    static let getChargingData = "/getChargingData"
    static let generateTransactionToken = "/generateTransactionToken"
    static let getPaytmTxnStatus = "/getPaytmTxnStatus"
    static let getPhonePeChecksum = "/getPhonePeChecksum"
    static let getPhonePeTxnStatus = "/getPhonePeTxnStatus"
    static let addReceipt = "/addReceipt"
    static let addAmountToLedger = "/addAmountToLedger"
    static let addVehicleInformationToTransactionConnector = "/addVehicleInformationToTransactionConnector"
    static let generateBillPDF = "/generateBillPDF"
    static let getMultipleChargingData = "/getMultipleChargingData"
    static let addCustomerRating = "/addCustomerRating"
    static let getHasCustomerRated = "/getHasCustomerRated"
    
    static let addPartnerCPOReceipt = "/addPartnerCPOReceipt"
    static let getAllCPOTransactionsByMobileNumber = "/getAllCPOTransactionHistoryByMobileNumber"
    static let getThisMonthCPOTransactionsByMobileNumber = "/getThisMonthCPOTransactionByMobileNumber"
    static let getThisYearCPOTransactionsByMobileNumber = "/getThisYearCPOTransactionByMobileNumber"
    static let generateBillPDFCPO = "/generateBillPDFCPO"
    static let getCPOByMobileNumberForStatusUpdate = "/getCPOByMobileNumberForStatusUpdate"
    static let updateCPOStatus = "/updateCPOStatus"
    static let getAllMachinesByPartnerCompanyCode = "/getAllMachinesByPartnerCompanyCode"
    static let getPartnerCompany = "/getPartnerCompany"
    
    //addVehicleInformationToTransactionConnector
//https://volttic.co//.in/cms/webservice/iosservice/addVehicleInformationToTransactionConnector

}

