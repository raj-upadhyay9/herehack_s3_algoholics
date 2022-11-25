import type { SexType } from '@faker-js/faker';
import { faker } from '@faker-js/faker';
const { PrismaClient } = require('@prisma/client')

const prisma = new PrismaClient()

const _ = require('lodash');

class User {
  id: number;
  name:string;
  email: string;
  phone: number;
  age: number;
  blood: string;
  height: number;
  gender: SexType;
  address: string;
  phonelist: number[];
}

function myRandomIntByMax(n){
    return Math.floor(Math.random() * n) + 1
  }

function createRandomUser(): User {
    let bloodType: string[] = ['A+','A','B','B-','AB'];
    return {
      id: myRandomIntByMax(10000),
      name: faker.name.firstName()+" "+faker.name.lastName(),
      email: faker.internet.email(),
      phone : myRandomIntByMax(1000),
      age: myRandomIntByMax(10000),
      blood: bloodType[Math.floor(Math.random() * bloodType.length)],
      height: myRandomIntByMax(1000),
      gender: faker.name.sexType(),
      address: faker.address.streetAddress()+" "+faker.address.cityName(),
      phonelist:[myRandomIntByMax(1000)]
    };
  }
  
  async function main() {
    let arr = [];
    _.range(10).forEach(x => arr.push(createRandomUser()));
    // console.log(arr);
    const createMany = await prisma.user.createMany({
        data: arr,
        skipDuplicates: true,
      })
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })
