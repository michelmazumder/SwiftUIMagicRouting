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
			ForEach(viewModel.items, id: \.self) {
				item in
				HStack {
					Button(item) { viewModel.selectItem(item: item) }
				}
				.padding()
			}
		}
		.frame(minWidth: 400, idealWidth: 600, minHeight: 450, idealHeight: 800)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
		MainMenuView(viewModel: MainMenuViewModel())
    }
}
