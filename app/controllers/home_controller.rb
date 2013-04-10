class HomeController < ApplicationController
  require "google_drive"

  def index

  end

  def create_spreadsheet
    session = GoogleDrive.login(USERNAME, PASSWORD)

    ws = session.spreadsheet_by_key(KEY).worksheets[0]

    ws[1,2] = 'Participant Information'
    ws[1,7] = 'Parent Information'

    ws[2,1] = 'First Name'
    ws[2,2] = 'Last Name'
    ws[2,3] = 'Age'
    ws[2,4] = 'T-Shirt Size'
    ws[2,6] = 'Parent Name'
    ws[2,7] = 'E-mail'
    ws[2,8] = 'Contact No.'

    ws[ws.num_rows+1,1] = params[:fname]
    ws[ws.num_rows,2] = params[:lname]
    ws[ws.num_rows,3] = params[:age]
    ws[ws.num_rows,4] = params[:tshirt]
    ws[ws.num_rows,6] = params[:pname]
    ws[ws.num_rows,7] = params[:email]
    ws[ws.num_rows,8] = params[:phone]

    # Save the data to Google Spreadsheet=
    ws.save()

    # Reloads the worksheet to get changes by other clients.
    ws.reload()
    flash[:success] = "You are successfully registered to our site !!! "
    redirect_to root_path

  rescue
    flash[:error] = "You are not registered to our site. Please fill the registration details !!!"
    redirect_to root_path

  end
end