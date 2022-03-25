using System;
using System.Collections.Generic;
using System.Text;

namespace Bakery.Models.BakedFoods.Contracts
{
    public class Bread : BakedFood
    {
        public Bread(string name, decimal price) :
            base(name, 200, price)
        {
        }
    }
}
