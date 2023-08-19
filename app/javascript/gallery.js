//const thumbs = document.querySelectorAll('.thumb');
//console.log(thumbs)
//thumbs.forEach(function(item,index){
//  item.onclick = function(){
//  document.geElementById('mainimg').src = this.dataset.image;
//  }
//});

document.addEventListener("DOMContentLoaded", function() {
  const thumbnails = document.querySelectorAll(".thumb"); // サムネイル要素を取得

  thumbnails.forEach(thumbnail => {
    thumbnail.addEventListener("click", function() {
      const mainImage = document.getElementById("mainimg"); // メイン画像要素を取得
      const newMainImageUrl = this.getAttribute("src"); // クリックしたサムネイルの画像URLを取得
      mainImage.setAttribute("src", newMainImageUrl); // メイン画像のURLを更新
    });
  });
});