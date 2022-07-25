class EmployeeTicketsController < ApplicationController
    def create
        ticket = Ticket.find(params[:id])
        employee = Employee.find(params[:employee_id])
        association = EmployeeTicket.create!(employee:employee, ticket:ticket)
        redirect_to "/employees/#{employee.id}"
    end
end