var express = require('express');
var router = express.Router();

const { parse } = require('postgres-array')
const { PrismaClient } = require('@prisma/client')

function toJson(data) {
    if (data !== undefined) {
        let intCount = 0, repCount = 0;
        const json = JSON.stringify(data, (_, v) => {
            if (typeof v === 'bigint') {
                intCount++;
                return `${v}#bigint`;
            }
            return v;
        });
        const res = json.replace(/"(-?\d+)#bigint"/g, (_, a) => {
            repCount++;
            return a;
        });
        if (repCount > intCount) {
            // You have a string somewhere that looks like "123#bigint";
            throw new Error(`BigInt serialization conflict with a string value.`);
        }
        return res;
    }
}


const prisma = new PrismaClient()

router.get('/', async function(req, res){
    const allemergency = await prisma.emergency.findMany()
      res.status(200).json(toJson(allemergency))
});

function myRandomIntByMax(n){
    return Math.floor(Math.random() * n) + 1
  }


router.post('/add', async function(req, res){
   
    // console.log(JSON.parse(req.query.phonelist));
    let emergency_id = myRandomIntByMax(100000);
    await prisma.emergency.create({
        data: {
          em_id: emergency_id,
          type: req.query.type,
          source: parse(req.query.source,value => parseFloat(value)),
          destination: parse(req.query.destination,value => parseFloat(value)),
          status: req.query.status,
          description: req.query.description,
          id: Number(req.query.id),
        },
      }).then(() => res.json(emergency_id))
      .catch(err => res.status(500).json(err));

});

router.get('/find', async function(req, res){
    const emergency = await prisma.emergency.findUnique({
        where:{
            em_id:Number(req.query.em_id)
        }
    })
      res.status(200).json(toJson(emergency))
});

//export this router to use in our index.js
module.exports = router;