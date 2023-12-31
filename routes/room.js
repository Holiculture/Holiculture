const router = require("express").Router();
const getCateKakao = require("../utils/getCateKakao");

router.get("/:page?", (req, response) => {
  let db = req.db; // server.js 에서 넘겨준 db

  db.collection("ticket").findOne(
    { uuid: req.header("uuid"), _id: parseInt(req.query.ticketId) },
    (err, result) => {
      if (err) return response.status(500).send("internet error");
      if (!result) return response.status(404).send("invalid ticket or uuid");

      getCateKakao(
        result,
        "AD5",
        req.query.distance,
        db,
        req.params.page || 1
      ).then(async (places) => {
        places
          ? response.status(200).send(places)
          : response.status(200).send([]);
      });
    }
  );
});

module.exports = router;
