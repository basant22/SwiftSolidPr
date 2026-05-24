//
//  PatientDetailVC.swift
//  SwiftSolidPr
//
//  Created by apple on 06/05/26.
//

import UIKit
import SwiftUI

class PatientDetailVC: UIViewController {

    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblSex: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    private var spinnerHostingController:UIHostingController<SpinnerView>?
    private var viewModal:PatientViewModal!
    private var patientId:Int!
    init(viewModal:PatientViewModal,patientId:Int){
        super.init(nibName: "PatientDetailVC", bundle: nil)
        self.viewModal = viewModal
        self.patientId = patientId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
       
        super.viewDidLoad()
        getPatientRecord()
        
        // Do any additional setup after loading the view.
    }
    func getPatientRecord(){
        viewModal.onObserveLoading = {[weak self] loading in
            if loading{
                self?.showSpinner()
            }else{
                self?.dismissSpinner()
            }
        }
        Task{[weak self] in
            do{
                
                try await viewModal.getPatientDetail(patientId: patientId)
//                if(!viewModal.isLoading){
//                    self?.dismissSpinner()
//                }
                self?.updateUI()
            }catch{
                print("\(error.localizedDescription)")
            }
        }
        
       
    }
    func updateUI(){
        guard let pDetail = viewModal.patientDetail else {return}
        lblFullName.text = pDetail.fullName
        lblAge.text = String(pDetail.age)
        lblSex.text = pDetail.sex
    }
    func showSpinner(){
       let spinnerVc = UIHostingController(rootView: SpinnerView())
        // Add as a child view controller
        addChild(spinnerVc)
        
        // 2. Setup the frame and appearance
        spinnerVc.view.translatesAutoresizingMaskIntoConstraints = false
        spinnerVc.view.backgroundColor = .clear // Keep the background transparent
        
        view.addSubview(spinnerVc.view)
        
        // 3. Constraints to center the spinner
        NSLayoutConstraint.activate([
            spinnerVc.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerVc.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinnerVc.view.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        spinnerVc.didMove(toParent: self)
        self.spinnerHostingController = spinnerVc
    }
    func dismissSpinner(){
        guard let hostingController = spinnerHostingController else { return }
        
        hostingController.willMove(toParent: nil)
        hostingController.view.removeFromSuperview()
        hostingController.removeFromParent()
        
        self.spinnerHostingController = nil
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
