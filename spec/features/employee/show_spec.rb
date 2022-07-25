require 'rails_helper'

RSpec.describe 'Employee Show Page' do 
    it 'shows the employees name and their department' do 
        it_dept = Department.create!(name: 'IT Department', floor: 'Basement')
        hr_dept = Department.create!(name: 'HR Department', floor: 'First Floor')


        mike = Employee.create!(name: 'Mike Dao', level: 4, department_id: it_dept.id)
        chris = Employee.create!(name: 'Christina Aguilera', level: 2, department_id: hr_dept.id)

        printer_ticket = Ticket.create!(subject: 'Printer is broken', age: 5)
        bathroom_ticket = Ticket.create!(subject: 'Bathroom is clogged', age: 1)
        lights_ticket = Ticket.create!(subject: 'Lights are out', age: 6)
        bored_ticket = Ticket.create!(subject: 'Bored so I made a ticket', age: 9)

        EmployeeTicket.create!(employee:chris, ticket:bathroom_ticket)
        EmployeeTicket.create!(employee:chris, ticket:printer_ticket)
        EmployeeTicket.create!(employee:chris, ticket:lights_ticket)

        visit "/employees/#{chris.id}"

        expect(page).to have_content('Christina Aguilera')
        expect(page).to have_content('HR Department')
        expect(page).to_not have_content('Mike Dao')
    end

    it 'shows their tickets from oldest to youngest not including the oldest ticket' do 
        hr_dept = Department.create!(name: 'HR Department', floor: 'First Floor')

        chris = Employee.create!(name: 'Christina Aguilera', level: 2, department_id: hr_dept.id)

        printer_ticket = Ticket.create!(subject: 'Printer is broken', age: 5)
        bathroom_ticket = Ticket.create!(subject: 'Bathroom is clogged', age: 1)
        lights_ticket = Ticket.create!(subject: 'Lights are out', age: 6)
        bored_ticket = Ticket.create!(subject: 'Bored so I made a ticket', age: 9)

        EmployeeTicket.create!(employee:chris, ticket:bathroom_ticket)
        EmployeeTicket.create!(employee:chris, ticket:printer_ticket)
        EmployeeTicket.create!(employee:chris, ticket:lights_ticket)
        


        visit "/employees/#{chris.id}"
       
        within "#employee-tickets" do 
            expect('Printer is broken').to appear_before('Bathroom is clogged')
            expect(page).to_not have_content('Lights are out')
            expect(page).to_not have_content('Bored so I made a ticket')
        end
    end

    it 'shows the oldest ticket in a seperate list from all the other tickets' do 
        hr_dept = Department.create!(name: 'HR Department', floor: 'First Floor')

        chris = Employee.create!(name: 'Christina Aguilera', level: 2, department_id: hr_dept.id)

        printer_ticket = Ticket.create!(subject: 'Printer is broken', age: 5)
        bathroom_ticket = Ticket.create!(subject: 'Bathroom is clogged', age: 1)
        lights_ticket = Ticket.create!(subject: 'Lights are out', age: 6)

        EmployeeTicket.create!(employee:chris, ticket:bathroom_ticket)
        EmployeeTicket.create!(employee:chris, ticket:printer_ticket)
        EmployeeTicket.create!(employee:chris, ticket:lights_ticket)
        


        visit "/employees/#{chris.id}"
       
        within "#oldest-ticket" do 
            expect(page).to have_content('Lights are out')
            expect(page).to_not have_content('Printer is broken')
            expect(page).to_not have_content('Bathroom is clogged')
        end
    end

    it 'has a form to add a ticket to this employee' do 
        it_dept = Department.create!(name: 'IT Department', floor: 'Basement')
        hr_dept = Department.create!(name: 'HR Department', floor: 'First Floor')


        mike = Employee.create!(name: 'Mike Dao', level: 4, department_id: it_dept.id)
        chris = Employee.create!(name: 'Christina Aguilera', level: 2, department_id: hr_dept.id)

        printer_ticket = Ticket.create!(subject: 'Printer is broken', age: 5)
        bathroom_ticket = Ticket.create!(subject: 'Bathroom is clogged', age: 1)
        lights_ticket = Ticket.create!(subject: 'Lights are out', age: 6)
        bored_ticket = Ticket.create!(subject: 'Bored so I made a ticket', age: 9)

        EmployeeTicket.create!(employee:chris, ticket:bathroom_ticket)
        EmployeeTicket.create!(employee:chris, ticket:printer_ticket)
        EmployeeTicket.create!(employee:chris, ticket:lights_ticket)

        visit "/employees/#{chris.id}"
        
        expect(page).to have_content('Add a ticket to this employee by submitting below the id of an already existing ticket')
        expect(page).to have_content('Id of already existing ticket:')
    end

    it 'has a form to add a ticket to this employee' do 
        it_dept = Department.create!(name: 'IT Department', floor: 'Basement')
        hr_dept = Department.create!(name: 'HR Department', floor: 'First Floor')


        mike = Employee.create!(name: 'Mike Dao', level: 4, department_id: it_dept.id)
        chris = Employee.create!(name: 'Christina Aguilera', level: 2, department_id: hr_dept.id)

        printer_ticket = Ticket.create!(subject: 'Printer is broken', age: 5)
        bathroom_ticket = Ticket.create!(subject: 'Bathroom is clogged', age: 1)
        lights_ticket = Ticket.create!(subject: 'Lights are out', age: 6)
        bored_ticket = Ticket.create!(subject: 'Bored so I made a ticket', age: 9)

        EmployeeTicket.create!(employee:chris, ticket:bathroom_ticket)
        EmployeeTicket.create!(employee:chris, ticket:printer_ticket)
        EmployeeTicket.create!(employee:chris, ticket:lights_ticket)

        visit "/employees/#{chris.id}"

        fill_in('id', with: "#{bored_ticket.id}")

        click_on('Add Ticket')
        
        expect(current_path).to eq("/employees/#{chris.id}")
        expect(page).to have_content('Bored so I made a ticket')
    end
end 