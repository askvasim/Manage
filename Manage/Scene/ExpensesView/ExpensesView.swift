//
//  ExpensesView.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct ExpensesView<VM: ExpensesViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultExpensesNavigator
    
    @State var expenseListData: ExpenseList?
    
    @State var isAddNewExpenseViewPresented: Bool = false
    @State var isExpenseDetailsViewPresented: Bool = false
    
    var body: some View {
        ZStack {
            CustomNavBarView(content: {
                ZStack {
                    content()
                        .onAppear {
                            AppState.shared.swipeEnabled = true
                        }
                        .onDisappear {
                            AppState.shared.swipeEnabled = false
                        }
                    
                    NavigationLink(destination: navigator.presentAddNewExpenseView(),
                                   isActive: $isAddNewExpenseViewPresented,
                                   label: { EmptyView() })
                    
                    NavigationLink(destination: navigator.presentExpenseDetailsView(expenseData: expenseListData),
                                   isActive: $isExpenseDetailsViewPresented,
                                   label: { EmptyView() })
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                
            }, title: "Expenses", otherScreens: true, addBackButton: true, filterButton: true) {
                //Back buttom press
            } stopTapped: {
                // Action
            } startTapped: {
                // Action
            } filterTapped: {
                // Action
                viewModel.isBottomSheetShown.toggle()
            } editTapped: {
                // Action
            } deleteTapped: {
                // Action
            }
            .onAppear {
                filterLead()
            }
            .onChange(of: viewModel.approvedExpense) { _, _ in
                filterLead()
            }
            .onChange(of: viewModel.pendingExpense) { _, _ in
                filterLead()
            }
            .onChange(of: viewModel.rejectedExpense) { _, _ in
                filterLead()
            }
            
            // Floating "+" Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // Action for adding a new lead
                        isAddNewExpenseViewPresented = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 18)
                                .frame(width: 56, height: 56)
                                .foregroundColor(AppColor.appPrimary)
                                .padding(.trailing, 25)
                            
                            Image("ic_add")
                                .resizable()
                                .frame(width: 56, height: 56)
                                .foregroundColor(AppColor.appPrimaryFont)
                                .padding(.trailing, 25)
                        }
                    }
                }
                .padding(.bottom, 10)
            }
        }
        .sheet(isPresented: $viewModel.isBottomSheetShown) {
            filterSheet()
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack {
                expenseCards()
            }
            .padding(.top, 10)
        }
    }
    
    private func filterSheet() -> some View {
        ZStack {
            AppColor.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                ZStack(alignment: .center) {
                    Text("Filter".uppercased())
                        .font(.appFont(.regular, size: 14))
                    
                    HStack {
                        Button {
                            viewModel.isBottomSheetShown.toggle()
                        } label: {
                            Image("ic_add_plus")
                                .resizable()
                                .font(.appFont(.regular, size: 14))
                                .foregroundColor(AppColor.appPrimaryFont)
                                .rotationEffect(.degrees(45))
                                .frame(width: 22, height: 22)
                        }
                        Spacer()
                    }
                }
                .padding(.top, 18)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                VStack(alignment: .leading, spacing: 16) {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .foregroundColor(AppColor.appGrayBackground)
                            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 168, maxHeight: 168)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("FILTER".uppercased())
                                .font(.appFont(.light, size: 10))
                                .foregroundColor(AppColor.appPrimaryFont)
                            
                            Toggle("Show approved expenses", isOn: $viewModel.approvedExpense)
                                .toggleStyle(SwitchToggleStyle(tint: Color.appPrimaryFont))
                            
                            Toggle("Show pending expenses", isOn: $viewModel.pendingExpense)
                                .toggleStyle(SwitchToggleStyle(tint: Color.appPrimaryFont))
                            
                            Toggle("Show rejected expenses", isOn: $viewModel.rejectedExpense)
                                .toggleStyle(SwitchToggleStyle(tint: Color.appPrimaryFont))
                        }
                        .padding(.horizontal, 20)
                    }
                }
                Spacer()
            }
        }
        .presentationDetents([.large, .large])
    }
    
    @ViewBuilder
    private func expenseCards() -> some View {
        ZStack {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.filteredExpenseListData, id: \.self) { expense in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(expense.tripDetail)
                                .font(.appFont(.medium, size: 20))
                            .foregroundColor(AppColor.black)
                            
                            Spacer()
                            
                            Text(formattedDate(expense.dateOfTrip))
                                .font(.appFont(.regular, size: 12))
                                .foregroundColor(AppColor.appGrayFontColor)
                        }
                        
                        HStack {
                            Text(expense.note)
                                .lineLimit(1)
                                .font(.appFont(.regular, size: 14))
                                .foregroundColor(AppColor.appGrayFontColor)
                        }
                    }
                    .frame(minWidth: 300, idealWidth: 350, maxWidth: .infinity, alignment: .leading)
                    .padding(.all, 25)
                    .background(expense.status == "Approved" ? AppColor.appLightGreen : expense.status == "Pending" ? AppColor.appLightYellow : AppColor.appLightRed)
                    .cornerRadius(20)
                    .onTapGesture {
                        expenseListData = expense
                        isExpenseDetailsViewPresented = true
                    }
                }
            }
            .padding(.horizontal, 25)
            .scrollTargetLayout()
        }
    }
    
    private func filterLead() {
        if !viewModel.approvedExpense && !viewModel.pendingExpense && !viewModel.rejectedExpense {
            // Show all lead if all toggles are off
            viewModel.filteredExpenseListData = viewModel.expenseListData
        } else {
            // Filter based on the toggles
            viewModel.filteredExpenseListData = viewModel.expenseListData.filter { lead in
                (lead.status == "Approved" && viewModel.approvedExpense) ||
                (lead.status == "Pending" && viewModel.pendingExpense) ||
                (lead.status == "Rejected" && viewModel.rejectedExpense)
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: date)
    }
}

#Preview {
    ExpensesView(viewModel: DefaultExpensesViewModel())
}
