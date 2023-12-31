//
//  HomeView.swift
//
//
//  Created by user246289 on 10/11/23.
//
import SwiftUI

struct HomeView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var selectedCenterID: String = "NA"
    @State private var isInventoryActive: Bool = false


    struct RecollectionCenter: Identifiable {
        var id: String
        var name: String
        var imageName: String
    }
    
    let recollectionCenters = [
        RecollectionCenter(id: "1", name: "Basilica de Zapopan", imageName: "BasilicaZ"),
        RecollectionCenter(id: "2", name: "Parque Colomos", imageName: "Colomos"),
        RecollectionCenter(id: "3", name: "Tlaquepaque", imageName: "Tlaque")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(#colorLiteral(red: 0.8666, green: 0.5215, blue: 0.0392, alpha: 1))
                    .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill(.white)
                    .frame(width: 300)
                    .offset(y: -257)
                
                VStack {
                    Imagen()
                        .frame(height: 170)
                    Text("Bienvenido \(authenticationViewModel.user?.email ?? "No user")")
                    Cards(recollectionCenters: recollectionCenters, selectedCenterID: $selectedCenterID) 
                }
                .padding(.bottom, 20)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Home")
                .toolbar {
                    Button("Logout") {
                        authenticationViewModel.logout()
                    }
                }
                .padding(.top, 40)
            }
        }
    }
}

struct Cards: View {
    let recollectionCenters: [HomeView.RecollectionCenter]
    @Binding var selectedCenterID: String 

    var body: some View {
        VStack(alignment: .leading) {
            Text("Centros de recoleccion")
                .font(.system(size: 27, weight: .bold, design: .serif))
                .foregroundColor(Color(.sRGB, red: 0.207, green: 0.18, blue: 0.38, opacity: 1))
                .padding(.top, 80)

            ScrollView(.horizontal) {
                HStack(spacing: 50) {
                    
                    ForEach(recollectionCenters) { center in
                        VStack {
                            Image(center.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 280, height: 300)
                                .cornerRadius(30)

                            VStack(alignment: .leading) {
                                NavigationLink(destination: CalendarView(selectedCenterID: center.id)
                                    .navigationBarBackButtonHidden(true)) {
                                    Text(center.name)
                                        .font(.system(size: 25, weight: .bold, design: .serif))
                                        .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 15)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .offset(y: -20)
                                        NavigationLink("in", destination: InventoryView(authenticationViewModel: AuthenticationViewModel()))
                                            .font(.system(size: 4, weight: .bold))
                                }
                            }
                            .frame(height: 100)
                        }
                    }
                    AddRecollectionCenterCard()
                }
            }
        }
        .padding(.leading, 50)
    }
}

struct AddRecollectionCenterCard: View {
    var body: some View {
        VStack {
            Image(systemName: "plus.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.blue)
                .padding(30)
                .background(Color.white)
                .cornerRadius(30)
                .onTapGesture {
                    
                }

            Text("Agregar")
            Text("Centro")
            Text("de Recolección")
        }
        .foregroundColor(Color.blue)
        .font(.system(size: 26, weight: .bold))
        .padding(100)
    }
}

struct HomeView_Previews: PreviewProvider {
     static var previews: some View {
         HomeView(authenticationViewModel: AuthenticationViewModel())
     }
}
