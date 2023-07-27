const router = require("express").Router();
const getCate = require("../utils/getCate");

router.get("/", (req, response) => {
  let db = req.db; // server.js 에서 넘겨준 db

  db.collection("ticket").findOne(
    { uuid: req.body.uuid, concert: req.body.concert },
    (err, result) => {
      getCate(result, "AD5", req.query.distance).then((places) => {
        places.forEach((place) => {
          place.cate = "숙소";
        });

        response.status(200).send(places);
      });
    }
  );
});

module.exports = router;