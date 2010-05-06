class CloudsController < ApplicationController
  def index
  end
  
  def fetchmsg
    @msgs = Inbox.all()
    count_msg = 0
    total_json = []
    @msgs.each{ |msg|
      total_json.push({:id=>msg['ID'], :msg=>msg['TextDecoded'], :sender=>msg['SenderNumber']})
      #msg.destroy
    }
    
    json_data = {:count=>total_json.length, :data=>total_json}
        
    respond_to do |format|
        format.js   { render :json => json_data }
    end
    
  end

end
