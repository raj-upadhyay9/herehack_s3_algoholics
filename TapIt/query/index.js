const { PrismaClient } = require('@prisma/client')

const prisma = new PrismaClient()


async function main() {
    await prisma.user.create({
        data: {
          id:122,
          name: 'lijjce',
          email: 'lije@prisma.io',
          phone: 2323456789,
          age: 21,
          blood: "O+",
          height: 134.23,
          gender: "F",
          address: "Delhi",
          phonelist: [
            324235235,
            234235325,
            324235312,
          ]
        },
      })
      const allUsers = await prisma.user.findMany({
        include: {
          emergency : true,
        },
      })
      console.dir(allUsers, { depth: null })
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