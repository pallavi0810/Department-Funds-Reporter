require "spec_helper"

describe Organization::ProcurementDepartment do
  context 'cash' do
  	it "should return cash  as 200 for a Procurement Department having funds as 200" do
  		department1 = FactoryGirl.build(:procurement_department, cash: 200)
  		expect(department1.cash).to eq(200)
  	end
  end

  context 'inventory' do
  	it "should return inventory  as 200 for a Procurement Department initialized with 200 products" do
  		department1 = FactoryGirl.build(:procurement_department, inventory: 200)
  		expect(department1.inventory).to eq(200)
  	end

    context 'Category' do
      it "should return inventory of black clothes as 40" do
        department = FactoryGirl.build(:procurement_department, inventory: 40, categories: {"colour" => "black"})
        expect(department.inventory_by_colour("black")).to eq(40)
      end

      it "should return inventory of black clothes as 0" do
        department = FactoryGirl.build(:procurement_department, inventory: 40, categories: {"colour" => "white"})
        expect(department.inventory_by_colour("black")).to eq(0)
      end

      it "should return inventory of black clothes as 0" do
        department = FactoryGirl.build(:procurement_department, inventory: 40)
        expect(department.inventory_by_colour("black")).to eq(0)
      end

      it "should return inventory as 0" do
        department = FactoryGirl.build(:procurement_department, inventory: 40)
        expect(department.inventory_of_black_and_not_jeans_or_t_shirts).to eq(0)
      end

      it "should return inventory of black clothes which are jeans as 0 " do
        department = FactoryGirl.build(:procurement_department, inventory: 40, categories: {"garment_subtype" => "jeans", "colour" => "black"})
        expect(department.inventory_of_black_and_not_jeans_or_t_shirts).to eq(0)
      end

      it "should return inventory of black clothes which are t shirts as 0 " do
        department = FactoryGirl.build(:procurement_department, inventory: 40, categories: {"garment_subtype" => "t_shirt", "colour" => "black"})
        expect(department.inventory_of_black_and_not_jeans_or_t_shirts).to eq(0)
      end

      it "should return inventory of black clothes which are formal shirts as 40 " do
        department = FactoryGirl.build(:procurement_department, inventory: 40, categories: {"garment_subtype" => "formal_shirt", "colour" => "black"})
        expect(department.inventory_of_black_and_not_jeans_or_t_shirts).to eq(40)
      end

      it "should return inventory of white clothes which are formal shirts as 0 " do
        department = FactoryGirl.build(:procurement_department, inventory: 40, categories: {"garment_subtype" => "formal_shirt", "colour" => "white"})
        expect(department.inventory_of_black_and_not_jeans_or_t_shirts).to eq(0)
      end

      context "inventory of less funding dept of given colour" do
        it "should return inventory as 0 if department colour is black and given colour is white" do
          department = FactoryGirl.build(:procurement_department, inventory: 40, categories: {"colour" => "black"})
          expect(department.inventory_of_less_funding_dept_of_given_colour("white", 400)).to eq(0)
        end

        it "should return inventory as 0 if funding is more than given funding" do
          department = FactoryGirl.build(:procurement_department, inventory: 40, cash: 1000)
          expect(department.inventory_of_less_funding_dept_of_given_colour("white", 400)).to eq(0)
        end

        it "should return inventory as 40 if funding is less than given funding and the colours match as per requirement" do
          department = FactoryGirl.build(:procurement_department, inventory: 40, cash: 100, categories: {"colour" => "white"})
          expect(department.inventory_of_less_funding_dept_of_given_colour("white", 400)).to eq(40)
        end
      end
    end
  end
  
end