# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

it_dept = Department.create!(name: 'IT Department', floor: 'Basement')
hr_dept = Department.create!(name: 'HR Department', floor: 'First Floor')

chris = Employee.create!(name: 'Christina Aguilera', level: 2, department_id: hr_dept.id)
ariana = Employee.create!(name: 'Ariana Grande', level: 3, department_id: hr_dept.id)
mike = Employee.create!(name: 'Mike Dao', level: 4, department_id: it_dept.id)

printer_ticket = Ticket.create!(subject: 'Printer is broken', age: 5)
bathroom_ticket = Ticket.create!(subject: 'Bathroom is clogged', age: 1)
lights_ticket = Ticket.create!(subject: 'Lights are out', age: 6)
bored_ticket = Ticket.create!(subject: 'Bored so I made a ticket', age: 9)

EmployeeTicket.create!(employee:chris, ticket:printer_ticket)
EmployeeTicket.create!(employee:chris, ticket:bathroom_ticket)

EmployeeTicket.create!(employee:ariana, ticket:printer_ticket)

EmployeeTicket.create!(employee:mike, ticket:printer_ticket)
EmployeeTicket.create!(employee:mike, ticket:bathroom_ticket)
EmployeeTicket.create!(employee:mike, ticket:lights_ticket)