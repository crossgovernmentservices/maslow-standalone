require_relative '../integration_test_helper'

class ViewANeedTest < ActionDispatch::IntegrationTest

  setup do
    login_as_stub_user
    need_api_has_organisations(
      "driver-vehicle-licensing-agency" => "Driver and Vehicle Licensing Agency",
      "driving-standards-agency" => "Driving Standards Agency",
    )
  end

  context "given a need which exists" do
    setup do
      setup_need_api_responses(101350)
    end

    should "show basic information about the need" do
      visit "/needs"
      click_on "101350"

      within ".need-breadcrumb" do
        assert page.has_link?("All needs", href: "/needs")
        assert page.has_content?("Book a driving test")
      end

      within "#single-need" do
        within "header" do
          within ".organisations" do
            assert page.has_content?("Driver and Vehicle Licensing Agency, Driving Standards Agency")
          end

          assert page.has_content?("Book a driving test")
          assert page.has_link?("Edit need", href: "/needs/101350/edit")
        end

        within ".the-need" do
          assert page.has_content?("As a user \nI need to book a driving test \nSo that I can get my driving licence")
        end

        within ".met-when" do
          assert page.has_content?("Users can book their driving test")
          assert page.has_content?("Users can find out information about the format of the test and how much it costs")
        end

        within ".justifications" do
          assert page.has_content?("It's something only government does")
          assert page.has_content?("It's straightforward advice that helps people to comply with their statutory obligations")
        end

        within ".impact" do
          assert page.has_content?("If GOV.UK didn't meet this need it would be noticed by the average member of the public")
        end

        within ".evidence" do
          assert page.has_content?("824k Average pageviews a month")
          assert page.has_content?("32.6% of site pageviews")
          assert page.has_content?("8k Average contacts a month")
          assert page.has_content?("630k Average searches a month")
        end
      end
    end
  end

  context "given a need with missing attributes" do
    setup do
      setup_need_api_responses(101500)
    end

    should "show basic information about the need" do
      visit "/needs"
      click_on "101500"

      within "#single-need" do
        within "header" do
          assert page.has_no_selector?(".organisations")

          assert page.has_content?("Book a driving test")
          assert page.has_link?("Edit need", href: "/needs/101500/edit")
        end

        within ".the-need" do
          assert page.has_content?("As a user \nI need to book a driving test \nSo that I can get my driving licence")
        end

        assert page.has_no_selector?(".met-when")
        assert page.has_no_selector?(".justifications")
        assert page.has_no_selector?(".impact")
        assert page.has_no_selector?(".evidence")
      end
    end
  end

  context "given a need which doesn't exist" do
    setup do
      need_api_has_no_need("101007")
    end

    should "display a not found error message" do
      visit "/needs/101007"

      assert page.has_content?("The page you were looking for doesn't exist.")
    end
  end

end
