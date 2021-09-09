//
//  MenuChoiceView.swift
//  MagicRouting
//
//  Created by Michel on 08/09/21.
//

import SwiftUI

struct MenuChoiceView: View {
	
	@ObservedObject var viewModel: MenuChoiceViewModel
	
    var body: some View {
		VStack {

			Text("Sono Menu Choice View")
				.font(.title)
				.padding()

			Text(viewModel.dataModel.selectedEntry ?? "-")
				.padding()
			
			Spacer()
			
			Button("Back", action: viewModel.back)
				.padding()

		}
		.frame(minWidth: 400, idealWidth: 600, minHeight: 450, idealHeight: 800)

    }
}

struct MenuChoiceView_Previews: PreviewProvider {
    static var previews: some View {
		MenuChoiceView(viewModel: MenuChoiceViewModel(dataModel: MenuModel(selectedEntry: "test")))
    }
}
