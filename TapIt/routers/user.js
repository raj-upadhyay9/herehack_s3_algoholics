var express = require('express');
var router = express.Router();

const { parse } = require('postgres-array')
const { PrismaClient } = require('@prisma/client')
const {uid} = require('uid');

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
    const allUsers = await prisma.user.findMany()
      res.status(200).json(toJson(allUsers))
});

function myRandomIntByMax(n){
    return Math.floor(Math.random() * n) + 1
  }

router.post('/add', async function(req, res){
   
    // console.log(JSON.parse(req.query.phonelist));
    
    let user_id = myRandomIntByMax(100000);

    await prisma.user.create({
        data: {
          id:user_id,
          name: req.query.name,
          email: req.query.email,
          phone: Number(req.query.phone),
          age: Number(req.query.age),
          blood: req.query.blood,
          height: parseFloat(req.query.height),
          gender: req.query.gender,
          address: req.query.address,
          phonelist: parse(req.query.phonelist,value => parseInt(value,10))
        },
      }).then(() => res.json(user_id))
      .catch(err => res.status(500).json(err));

});

router.get('/find', async function(req, res){
    const user = await prisma.user.findUnique({
        where:{
            id:Number(req.query.id)
        }
    })
      res.status(200).json(toJson(user))
});

//export this router to use in our index.js
module.exports = router;