require 'rails_helper'

RSpec.describe 'Department Index Page' do 
    it 'shows each departments name and floor' do 
        it_dept = Department.create!(name: 'IT Department', floor: 'Basement')
        hr_dept = Department.create!(name: 'HR Department', floor: 'First Floor')

        visit '/departments'

        within "#department-#{it_dept.id}" do 
            expect(page).to have_content('IT Department')
            expect(page).to have_content('Basement')
            expect(page).to_not have_content('HR Department')
        end 

        within "#department-#{hr_dept.id}" do 
            expect(page).to have_content('HR Department')
            expect(page).to have_content('First Floor')
            expect(page).to_not have_content('IT Department')
        end 
    end
    
    it 'shows each departments employees' do 
        it_dept = Department.create!(name: 'IT Department', floor: 'Basement')
        hr_dept = Department.create!(name: 'HR Department', floor: 'First Floor')

        chris = Employee.create!(name: 'Christina Aguilera', level: 2, department_id: hr_dept.id)
        ariana = Employee.create!(name: 'Ariana Grande', level: 3, department_id: hr_dept.id)
        mike = Employee.create!(name: 'Mike Dao', level: 4, department_id: it_dept.id)

        visit '/departments'
        
        within "#department-#{it_dept.id}" do 
            expect(page).to have_content('Mike Dao')
            expect(page).to_not have_content('Ariana Grande')
            expect(page).to_not have_content('Christina Aguilera')
        end 

        within "#department-#{hr_dept.id}" do 
            expect(page).to_not have_content('Mike Dao')
            expect(page).to have_content('Ariana Grande')
            expect(page).to have_content('Christina Aguilera')
        end 
    end
end