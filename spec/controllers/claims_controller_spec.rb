require 'rails_helper'

describe ClaimsController do

  describe "show action" do
    it "renders error if you doesn`t have admin permissions" do
      claim = create(:claim)
      get :show, { id: claim.id}
      expect(response).to redirect_to(login_path)
    end
  end

  describe "create action" do
    it "redirects to claim page if validations pass" do
      post :create, claim: { lastname: "lastname", phone: "+38(063)78456925", latitude: "50.1", longitude: "54.2", theme: "theme", text: "text"}
      expect(response).to redirect_to(thanks_path(id: assigns(:claim).id))
    end

    it "renders new page again if validations fail" do
      post :create, claim: { lastname: "lastname", phone: nil, latitude: "50.1", longitude: "54.2", theme: "theme", text: "text"}
      expect(response).to redirect_to(new_claim_path)
    end
  end

  describe "all income claims" do
    it "should show all income claims" do
      post :create, claim: { lastname: "lastname", phone: "+38(063)78456925", latitude: "50.1", longitude: "54.2", theme: "theme", text: "text"}
      expect(assigns(:claim)).to_not be_nil
    end
  end


  describe "crews list" do
    it "should show all crews" do
      post :create, claim: { lastname: "lastname", phone: "+38(063)78456925", latitude: "50.1", longitude: "54.2", theme: "theme", text: "text"}
      expect(assigns(:claim).crews).to_not be_nil
    end
  end
end
