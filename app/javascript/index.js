
window.addEventListener('load', function(){

  // 投票日と現在日時との差分を計算
  function countdown(due) {
    const now = new Date;

    const rest = due.getTime() - now.getTime();
    const sec = Math.floor(rest / 1000) % 60;
    const min = Math.floor(rest / 1000 / 60) % 60;
    const hours = Math.floor(rest / 1000 / 60 / 60) % 24;
    const days = Math.floor(rest / 1000 / 60 / 60/ 24);
    const count = [days,hours,min,sec];
    return count
  }

  // 投票日設定
  let electionDay = new Date(2021,12,31,20,);

  console.log(countdown(electionDay));


  function recalc() {
    const counter = countdown(electionDay);
    console.log(counter);

    document.getElementById('day').textContent = counter[0];
    document.getElementById('hour').textContent = counter[1];
    document.getElementById('min').textContent = String(counter[2]).padStart(2,'0');
    document.getElementById('sec').textContent = String(counter[3]).padStart(2,'0');
    refresh();  
  }

  // 1秒毎に表示
  function refresh() {
    setTimeout(recalc,1000);
  }

  recalc();
})