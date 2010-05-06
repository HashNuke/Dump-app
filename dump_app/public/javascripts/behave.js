//var intervalID = window.setInterval(updateDisplay, 2000);
//window['localStorage'].setItem("offlineHolder","");

var offlineHolder = new Array();

function saveToLocal(data)
{
    //window['localStorage'].setItem("offlineHolder",""+data);
    offlineHolder = data;
}

function fillUp(){
    console.log("fill up");
    var tempMsg = 0;
    
    /*if(eval(window['localStorage'].getItem("offlineHolder")).length!=0 && window['localStorage'].getItem("offlineHolder")!="")
    */
    if(getFromLocal().length!=0)
    {
        addFromHolder();
    }
    else
    {
        fetchMsgs();
        addFromHolder();
    }
}

function fillNew(){
    var tempMsg = 0;
    
    /*if(eval(window['localStorage'].getItem("offlineHolder")).length!=0 && window['localStorage'].getItem("offlineHolder")!="")
    */
    if(getFromLocal().length!=0)
    {
        addOne();
    }
    else
    {
        fetchMsgs();
        addOne();
    }
}



function addFromHolder()
{
    var tempStr = 0;
    var tempMsg = 0;
    //console.log(window['localStorage'].getItem("offlineHolder"));
    /*if(eval(window['localStorage'].getItem("offlineHolder")).length<5 && window['localStorage'].getItem("offlineHolder")!="") */
    if(getFromLocal().length<5)
            var tCount = getFromLocal().length;
        else
            var tCount = 5;

        for(var i=0;i<tCount;i++)
            {
                tempMsg = getFromLocal().pop();
                //saveToLocal(offlineHolder);
                addBox(tempMsg.id,tempMsg.sender,tempMsg.msg);
                i=i+1;
            }
}

function addOne()
{
    var tempStr = 0;
    var tempMsg = 0;
    //console.log(window['localStorage'].getItem("offlineHolder"));
    /*if(eval(window['localStorage'].getItem("offlineHolder")).length<5 && window['localStorage'].getItem("offlineHolder")!="") */
    if(getFromLocal().length>0)
    {
        tempMsg = getFromLocal().pop();
        addBox(tempMsg.id,tempMsg.sender,tempMsg.msg);
    }
}

function fetchMsgs()
{
    var tempStr = new Array();
    console.log("fetchMsgs");
    $.getJSON('/fetchmsg', function(data){
            if(data.count!=0)
            {
                for (var i in data.data)
                    {
                        tempStr.push(data.data[i]);
                    }
                 saveToLocal(tempStr);
                 //console.log(window['localStorage'].getItem("offlineHolder"));
            }
        });
}

function addBox(id, sender, msg)
{
   
    if($("#infobox").children().length==5)
    {
        //remove box
        $("#infobox").children().eq($("#infobox").children().length-1).fadeOut('slow');
        $("#infobox").children().eq($("#infobox").children().length-1).remove();
    }
    $("#infobox").prepend("<div class='msgbox span-12' style='display:none;' id='msg"+id+"'><div class='span-11 msgContent'>"+msg+"</div><div class='span-11 msgNum'>"+sender+"</div></div>");
    $("#msg"+id).fadeIn('slow');
}

function updateDisplay()
{
    //if(eval(window['localStorage'].getItem("offlineHolder")).length==0)
    if(getFromLocal().length==0)
    {
        fillUp();
    }
    else
    {
        addFromHolder();
    }    
}

function getFromLocal()
{
    return offlineHolder;
}

fetchMsgs();
fillUp();
