using Bakery.Models.BakedFoods.Contracts;
using Bakery.Models.Drinks.Contracts;
using System;
using System.Collections.Generic;
using System.Text;

namespace Bakery.Models.Tables.Contracts
{
    public abstract class Table : ITable
    {
        private List<IBakedFood> bakedFoods;
        private List<IDrink> drinks;
        private int tableNumber;
        private int capacity;
        private decimal pricePerPerson;
        private int numberOfPeople;
        public Table(int tableNumber, int capacity, decimal pricePerPerson)
        {
            TableNumber = tableNumber;
            Capacity = capacity;
            PricePerPerson = pricePerPerson;
            bakedFoods = new List<IBakedFood>();
            drinks = new List<IDrink>();
        } 
        
        public int TableNumber { get; private set; }

        public int Capacity
        {
            get => capacity;
            private set
            {
                if (value < 0 )
                {
                    throw new ArgumentException("Capacity has to be greater than 0");
                }
                capacity = value;
            }
        }

        public int NumberOfPeople
        {
            get => numberOfPeople;
            private set
            {
                if (value <= 0)
                {
                    throw new ArgumentException("Cannot place zero or less people!");
                }
                capacity = value;
            }
        }

        public decimal PricePerPerson { get; private set; }
        

        public bool IsReserved { get; private set; }
       

        public decimal Price
        {
            get
            {
                return PricePerPerson * NumberOfPeople;
            }
        }

        public void Clear()
        {
            bakedFoods.Clear();
            drinks.Clear();
            NumberOfPeople = 0;
            IsReserved = false;
        }

        public decimal GetBill()
        {
            decimal bill = 0;

            foreach (var drink in drinks)
            {
                bill += drink.Price;
            }

            foreach (var food in bakedFoods)
            {
                bill += food.Price;
            }
            bill += Price;

            return bill;
        }

        public string GetFreeTableInfo()
        {
            return $"Table: {TableNumber}\r\n" +
            $"Type: {this.GetType().Name}\r\n" +
            $"Capacity: {Capacity}\r\n" +
            $"Price per Person: {PricePerPerson}";

        }

        public void OrderDrink(IDrink drink)
        {
            this.drinks.Add(drink);
        }

        public void OrderFood(IBakedFood food)
        {
            this.bakedFoods.Add(food);
        }

        public void Reserve(int numberOfPeople)
        {
            IsReserved = true;
            NumberOfPeople = numberOfPeople;
        }
    }
}
