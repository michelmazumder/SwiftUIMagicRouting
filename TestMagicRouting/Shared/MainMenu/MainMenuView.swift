//
//  MainMenuView.swift
//  MagicRouting
//
//  Created by Michel on 08/09/21.
//

import SwiftUI

struct MainMenuView: View {
	
	@ObservedObject var viewModel: MainMenuViewModel
	
    var body: some View {
		VStack {
			ForEach(viewModel.ctas, id: \.self) {
				item in
				HStack {
					Button(item) { viewModel.selectItem(item: item) }
				}
				.padding()
			}
		}
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
		MainMenuView(viewModel: MainMenuViewModel())
    }
}
