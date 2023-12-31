const getImgKakao = require("./getImgKakao");

let isEndPage = false;

const getCateKakao = (ticket, cate, distance, db, page) => {
  return fetch(
    `https://dapi.kakao.com/v2/local/search/category.json?category_group_code=${cate}&page=${page}&size=10&sort=accuracy&x=${parseFloat(
      ticket?.posX
    )}&y=${parseFloat(ticket?.posY)}&radius=${parseInt(distance) || 500}`,
    {
      method: "GET",
      headers: { Authorization: process.env.KAKAO_API },
    }
  )
    .then((response) => {
      return response.json();
    })
    .then(async (data) => {
      if (parseInt(page) === 1) isEndPage = false;
      if (isEndPage) return [];
      if (page >= 20) {
        isEndPage = true;
        return [];
      }
      isEndPage = data.meta.is_end;

      let places = data.documents?.map((place) => {
        return {
          place_name: place.place_name,
          place_url: place.place_url,
          category_name: place.category_name?.match(/>([^>]+)$/)[1]?.trim(),
          distance: place.distance,
          x: place.x,
          y: place.y,
          road_address_name: place.road_address_name,
        };
      });

      for (let i = 0; i < places?.length; i++) {
        // isLike 추가 작업
        db.collection("like").findOne(
          {
            uuid: ticket.uuid,
            road_address_name: places[i].road_address_name,
          },
          (err, result) => {
            if (err) throw err;
            places[i].isLike = result ? true : false;
          }
        );
        // 이미지 추가 작업 (이미지가 없다면 places에서 제거시킴)
        let image = await getImgKakao(places[i]);
        if (image) places[i].img = image.replace(/^http(?!s)/, "https");
        else {
          places.splice(i--, 1);
          continue;
        }
      }

      return places;
    });
};

module.exports = getCateKakao;
