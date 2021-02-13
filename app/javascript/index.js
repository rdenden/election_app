//日付を指定


//時間を指定
let tH = 24;
//分を指定
let tM = 0;
//秒を指定
let tS = 0;

let timer = (()=>{
  // 指定時間までの差分を取得
  let getDeffer = ()=>{
    let today = new Date();
    let todayMilliSec = today.getTime();
    let nextDay = today.getDate() + 1 ;
    let targetTime = new Date(today.getFullYear(), today.getMonth(), today.getDate(), tH, tM, tS);
    let targetTimeMilliSec = targetTime.getTime();
    let deff = targetTimeMilliSec - todayMilliSec;
    return deff;
  }
  // 1秒おきにカウントダウン
  let display = setInterval(()=>{
    let ms = getDeffer();
    let flag = true;
    if (ms > 0) {
      let t = Math.round(ms / 1000);
      let h = Math.floor(t / 3600);
      let m = Math.floor((t - h * 3600) / 60);
      let s = Math.floor(t - h * 3600 - m * 60);
      count = document.getElementById('count')
      count.innerHTML = (' 投票期限まで 残り ' + addZero(h) + '時間' + addZero(m) + '分' + addZero(s) + '秒');
      if(flag === false){
        flag = true;
      }
    } else {
      if(flag === true){
      count.innerHTML =('投票期限は終了しました');
        flag = false;
      }
    }
  }, 1000);

  let addZero = function (num) {
    return ('0' + num).slice(-2);
  }
})();
