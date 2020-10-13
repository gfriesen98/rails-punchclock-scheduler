$(document).ready(function startTime(){
        var today = new Date();
        var h = today.getHours();
        var m = today.getMinutes();
        var s = today.getSeconds();
        m = checkTime(m);
        s = checkTime(s);
        // h = (h+24)%12+"PM" || 12+"AM";

        var time = (h > 12 ) ? ( h-12 + ":" + m + ":"+ s +'PM') : (h + ":" + m + ":" + s +'AM')

        document.getElementById('clock').innerHTML = time
        // h + ":" + m + ":" + s;
        var t = setTimeout(startTime, 500);
      function checkTime(i) {
        if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
        return i;
      }
});