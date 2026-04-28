//
//  PatientURLRequest.swift
//  SwiftSolidPr
//
//  Created by apple on 26/04/26.
//

import Foundation
protocol PatientURLRequestBuilder{
    func makeGetPatientRequest(take:Int,skip:Int)->URLRequest?
    func makeGetPatientSearchRequest(patintName:String)->URLRequest?
    func makeGetPatientDetailRequest(patintId:Int)->URLRequest?
    func makeGetPatientReportRequest(patintId:Int)->URLRequest?
    func downloadReport(url:URL)->URLRequest?
}
final class  PatientURLRequest:PatientURLRequestBuilder{
   private let baseURl:URL
    init(baseURL:URL  = URL(string: "https://api-dev-patient-portal.azurewebsites.net/api/")!){
        self.baseURl = baseURL
    }
    func makeGetPatientRequest(take:Int,skip:Int)->URLRequest?{
        let completeUrl = baseURl.appendingPathComponent("Patients")
        var component = URLComponents(url: completeUrl, resolvingAgainstBaseURL: false)
        component?.queryItems = [
            URLQueryItem(name: "Take", value: String(take)),
            URLQueryItem(name: "Skip", value: String(skip)),
        ]
        guard let url = component?.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    func makeGetPatientSearchRequest(patintName:String)->URLRequest?{
        let completeUrl = baseURl.appendingPathComponent("Patients/searc")
        var component = URLComponents(url: completeUrl, resolvingAgainstBaseURL: false)
        component?.queryItems = [
            URLQueryItem(name: "Name", value: String(patintName)),
            
        ]
        guard let url = component?.url else {return nil}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    func makeGetPatientDetailRequest(patintId:Int)->URLRequest?{
        let completeUrl = baseURl.appendingPathComponent("Patients/PatientDetails")
        var component = URLComponents(url: completeUrl, resolvingAgainstBaseURL: false)
        component?.queryItems = [
            URLQueryItem(name: "id", value: String(patintId)),
            
        ]
        guard let url = component?.url else {return nil}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    func makeGetPatientReportRequest(patintId:Int)->URLRequest?{
        let completeUrl = baseURl.appendingPathComponent("Report/Download")
        var request = URLRequest(url: completeUrl)
        request.httpMethod = "POST"
        let payload:[Int] = [patintId]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            let body = try JSONSerialization.data(withJSONObject: payload, options: [])
            request.httpBody = body
            return request
        }catch{
            return nil
        }
    }
    func downloadReport(url:URL)->URLRequest?{
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
