//
//  LoginView.swift
//  MagicRouting
//
//  Created by Michel on 08/09/21.
//

import SwiftUI

struct LoginView: View {

	@ObservedObject var viewModel: LoginViewModel
	
    var body: some View {
		
		VStack {
			HStack {
				Text("User name: ").padding()
				TextField("user name", text: $viewModel.userName)
			}
			.padding()
			
			HStack {
				Text("Password: ").padding()
				SecureField("Password", text: $viewModel.password)
			}
			.padding()
			
			HStack {
				Button("Login", action: viewModel.login)
			}
			.padding()
			
			if viewModel.errorMessage.count > 0 {
				Text(viewModel.errorMessage)
					.foregroundColor(.red)
					.padding()
			}
		}
		.frame(minWidth: 400, idealWidth: 600, minHeight: 450, idealHeight: 800)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
