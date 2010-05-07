class CloudsController < ApplicationController
  def index
  end
  
  def fetchmsg
    @msgs = Inbox.find(:all, :conditions=> {:approved=>"true", :displayed=>"false"}, :limit=>5)
    count_msg = 0
    total_json = []
    @msgs.each{ |msg|
      msg['SenderNumber'][0]=""
      msg['SenderNumber'][1]=""
      msg['SenderNumber'][2]=""
      msg['SenderNumber'][5]=""
      msg['SenderNumber'][6]=""
      msg['SenderNumber'][7]=""
      msg['SenderNumber'][8]=""
      msg['SenderNumber'][9]=""
      total_json.push({:id=>msg['ID'], :msg=>msg['TextDecoded'], :sender=>msg['SenderNumber']})
      @each_msg=Inbox.find(msg['ID'])
      @each_msg.id = msg['ID']
      @each_msg.displayed="true"
      @each_msg.save
    }
    
    json_data = {:count=>total_json.length, :data=>total_json}
    respond_to do |format|
        format.js   { render :json => json_data }
    end
  end

  def manage
    @msgs = Inbox.paginate :page=>params[:page], :conditions=> {:approved=>"false", :displayed=>"false"}
    render :layout=>"manage_sms"
  end

  def approve
    @msg = Inbox.find(params[:id])
    @msg.id = params[:id]
    @msg['approved']="true"
    @msg.save
    render :text=>"yes"
  end

  def reject
    @msg = Inbox.find(params[:id])
    @msg.id = params[:id]
    @msg.destroy
    render :text=>"yes"
  end
  
  
end
