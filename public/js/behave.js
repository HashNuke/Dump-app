var displayCount = 0;
var offlineHolder = [];
var intervalID = window.setInterval(updateScreen, 1000);

$(document).ready(function(){
        getMsg();
});

function getMsg()
{
    $.getJSON('/fetchmsg', function(data){
            if(data.count>0)
                {
                    for (var each_msg in data)
                        {
                            if(displayCount==0)
                                {
                                    pushAllToDisplay(data.data);
                                }
                            else
                                {
                                    pushEachToDisplay(data.data);
                                }
                        }
                }
        });
}

function pushAllToDisplay(msgData){
    var countMsg = 0;
    var tempMsg = "";
    for (var msg in msgData)
        {
            console.log(msg);
            tempMsg = msgData.pop();
            addBox(tempMsg['msg'], tempMsg['sender'], tempMsg['id']);
            countMsg = countMsg+1;
            displayCount = countMsg;
            if(countMsg==5)
                {
                    if(msgData.length>0)
                        for (var each_tempmsg in msgData)
                            offlineHolder.push(msgData[each_tempmsg]);
                return;
        }
}

function pushEachToDisplay(msgData){
    
}

function addBox(msg, number, id)
{
    
    $("#infobox").prepend("<div class='msgbox' style='display:none;' id='msg"+id+"'><div class='msgContent'>"+msg+"</div></div>");
    $("#msg"+id).fadeIn('slow');
}

//attach a function to be called at intervals to fetch msgs
function updateScreen(){
    //temp body
}