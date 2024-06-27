class AccessFormMailer < ApplicationMailer
    default to: 'info.thecricauction@gmail.com'
  
    def new_access_form(access_form)
      @access_form = access_form
      mail(subject: 'TheCricAuction | Access Request Recieved!')
    end
  end
  