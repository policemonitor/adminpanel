require 'rails_helper'
describe "Features" do
  describe "claims form" do

    before(:each) do
      visit 'http://localhost:3000/'
      click_on 'Надати заяву'
      expect(page).to have_content('Заява про правопорушення')
      fill_in 'Ваше Прізвище Ім’я По батькові', :with => 'Галущак Андрій Миколайович'
      fill_in 'Ваш номер телефону', :with=>"+38(050)2424424"
      fill_in 'Тема звернення', :with=>"Бійка"
      find(:xpath, ".//*[@id='new_claim']/div[4]/div/label", :visible => false).click
      fill_in 'Місце злочину', :with=>"Київ вул. Янгеля 20"
      fill_in 'Текст повідомлення', :with=>"Близько 18-30 на студента напали 3 невідомих особи у стані алкогольного сп'яніння'"
      click_on 'Відправити заяву'
      expect(page).to have_content('Заява прийнята!')
      @claim_id = find(:xpath, "html/body/div[1]/div/div/div/p[2]/b[1]").text
      expect(@claim_id).not_to be_nil
    end

    it "should find claims by it`s id", :js => true do
      visit 'http://localhost:3000/'
      click_on 'Пошук заяви у системі'
      fill_in 'Номер Вашої заяви', :with => "#{@claim_id}"
      fill_in 'Ваш номер телефону', :with => "+38(050)2424424"
      click_on 'Шукати'
      expect(page).to have_content('Заяву знайдено')
      click_on 'Завантажити PDF файл заяви'
      expect(page).to have_content('+38(050)2424424')
    end

  end


  describe "administrator cabinet" do

    it "should correctly enter to administrators cabinet", :js => true do
      visit 'http://localhost:3000/'
      click_on 'Увійти'
      fill_in 'Логін', :with=> "roman.kaporin"
      fill_in 'Пароль', :with=> "1q1q1q"
      find(:xpath, "html/body/div[1]/div/div/form/div[3]/input").click
      expect(page).to have_content "Капорін Роман Михайлович"
    end

    it "should correctly save crews information", :js => true do
      visit 'http://localhost:3000/'
      click_on 'Увійти'
      fill_in 'Логін', :with=> "roman.kaporin"
      fill_in 'Пароль', :with=> "1q1q1q"
      find(:xpath, "html/body/div[1]/div/div/form/div[3]/input").click
      click_on 'Капорін Роман Михайлович'
      expect(page).to have_content "Панель швидкого доступу"
      click_on 'Перегляд наявних екіпажів та їх редагування'
      find(:xpath, "html/body/div[1]/div[1]/form/div/h3/a").click
      fill_in 'Номер екіпажу', :with=>"0911"
      fill_in 'Номер автомобіля екіпажу', :with=>"AA9543MB"
      fill_in 'crew_vin_number', :with=>"1GCEC14T96Z101579"
      click_on "Зберегти дані"
      expect(page).to have_content "AA9543MB"
    end

    it "should correctly deliver an order", :js => true do
      visit 'http://localhost:3000/'
      click_on 'Увійти'
      fill_in 'Логін', :with=> "roman.kaporin"
      fill_in 'Пароль', :with=> "1q1q1q"
      find(:xpath, "html/body/div[1]/div/div/form/div[3]/input").click
      click_on 'Капорін Роман Михайлович'
      expect(page).to have_content "Панель швидкого доступу"
      find(:xpath, "html/body/div[1]/div/div/div[2]/div[3]/a[2]").click
      expect(page).to have_content "Перегляд усіх прийнятих заяв"
      click_on "Галущак Андрій Миколайович"
      find('label', :text => '0911').click
      click_on "Надати наказ"
      expect(page).to have_content "Наказ надано! Повідомьте екіпажі!"
      find(:xpath, "html/body/div[2]/div/div/div/div[2]/div/div/div/label", :visible => false).click
      click_on "Завершити"
      expect(page).to have_content "Надати заяву"
      click_on 'Капорін Роман Михайлович'
      find(:xpath, "html/body/div[1]/div/div/div[2]/div[3]/a[2]").click
      click_on "Галущак Андрій Миколайович"
      expect(page).to have_content "Статус заяви: Розглянуто"
    end
  end
end
