//
//  UserProfileCardView.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 17/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

enum ViewStade: String {
    case PaymentMethod, MyList
}

class UserProfileCardView: UIView {

    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var userEmailLB: UILabel!
    @IBOutlet weak var mainStateTV: UITableView!
    private var mFavBtn: WButton!
    private var mPaymentBtn: WButton!
    
    private var viewStade: ViewStade = .MyList
    
    class func instanceFromNib() -> UserProfileCardView {
        return UINib(nibName: "UserProfileCardView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UserProfileCardView
    }
    
    override func awakeFromNib() {
      setupView()
    }
    
    private func setupView() {
        self.mainStateTV.register(UINib(nibName: "PaymentCardCell", bundle: nil), forCellReuseIdentifier: "PaymentCardCell")
        self.mainStateTV.register(UINib(nibName: "FavCell", bundle: nil), forCellReuseIdentifier: "FavCell")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.buildSectionButtons()
        })
    }
    
    private func buildSectionButtons() {
        
        mFavBtn = WButton()
        mFavBtn.frame = CGRect(x: 0, y: 90, width: self.frame.width/2, height: 50)
        mFavBtn.setTitle("FavKey".localized(), for: .normal)
        mFavBtn.backgroundColor = .btnGreenColor
        mFavBtn.bntStade = 5
        mFavBtn.isHighlighted = true
        
        mFavBtn.addTarget(self, action: #selector(showMyFavAct), for: .touchUpInside)
        self.addSubview(mFavBtn)
        
        mPaymentBtn = WButton()
        mPaymentBtn.frame = CGRect(x: self.frame.width/2, y: 90, width: self.frame.width/2, height: 50)
        mPaymentBtn.setTitle("PaymentMethodKey".localized(), for: .normal)
        mPaymentBtn.backgroundColor = .btnGreenColor
        mPaymentBtn.bntStade = 5
        
        mPaymentBtn.addTarget(self, action: #selector(showPaymentMethodAct), for: .touchUpInside)
        self.addSubview(mPaymentBtn)
    }
    
    @objc private func showMyFavAct() {
        self.viewStade = .MyList
        mPaymentBtn.backgroundColor = .btnGreenColor
        DispatchQueue.main.async {
            self.mainStateTV.reloadData()
        }
    }
    
    @objc private func showPaymentMethodAct() {
        self.viewStade = .PaymentMethod
        mFavBtn.backgroundColor = .btnGreenColor
        DispatchQueue.main.async {
            self.mainStateTV.reloadData()
        }
    }
}

extension UserProfileCardView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch viewStade {
        case .PaymentMethod:
            return 1
        case .MyList:
            return UserPresenter.sharedIntance.getUserData()?.userFavList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewStade {
        case .PaymentMethod:
            
            let paymentCardCell = tableView.dequeueReusableCell(withIdentifier: "PaymentCardCell") as! PaymentCardTableViewCell
            paymentCardCell.setupCell()
            
            return paymentCardCell
            
        case .MyList:
            
            let mFavCell = tableView.dequeueReusableCell(withIdentifier: "FavCell") as! FavTableViewCell
            mFavCell.setupCell()
            
            return mFavCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch viewStade {
        case .PaymentMethod:
            return 300
        case .MyList:
            return 130
        }
    }
}
