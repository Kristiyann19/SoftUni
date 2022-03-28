using System;
using System.Collections.Generic;
using System.Linq;

namespace exercises
{
    class Program
    {
        static void Main(string[] args)
        {
            int gladius = 0; //70
            int shamshir = 0; //80
            int katana = 0; //90
            int sabre = 0; //110
            int broadsword = 0; //150

            int totalSwords = 0;

            int[] inputSteel = Console.ReadLine().Split(" ", StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToArray();
            int[] inputCarbon = Console.ReadLine().Split(" ", StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToArray();

            Queue<int> steel = new Queue<int>(inputSteel);
            Stack<int> carbon = new Stack<int>(inputCarbon);

            
            while (carbon.Count > 0 || steel.Count > 0)
            {

                if (steel.Count == 0)
                {
                    break;
                }
                if (carbon.Count == 0)
                {
                    break;
                }

                int currentSteel = steel.Peek();
                int currentCarbon = carbon.Peek();
                int sum = currentSteel + currentCarbon;

                if (sum == 70)
                {
                    gladius++;
                    totalSwords++;
                    steel.Dequeue();
                    carbon.Pop();
                }
                else if (sum == 80)
                {
                    shamshir++;
                    totalSwords++;
                    steel.Dequeue();
                    carbon.Pop();
                }
                else if (sum == 90)
                {
                    katana++;
                    totalSwords++;
                    steel.Dequeue();
                    carbon.Pop();
                }
                else if (sum == 110)
                {
                    sabre++;
                    totalSwords++;
                    steel.Dequeue();
                    carbon.Pop();
                }
                else if (sum == 150)
                {
                    broadsword++;
                    totalSwords++;
                    steel.Dequeue();
                    carbon.Pop();
                }
                else
                {
                    steel.Dequeue();
                    int currentValue = carbon.Pop();
                    int newValue = currentValue + 5;
                    carbon.Push(newValue);
                }
            }

            if (totalSwords > 0)
            {
                Console.WriteLine($"You have forged {totalSwords} swords.");
            }
            else
            {
                Console.WriteLine("You did not have enough resources to forge a sword.");
            }

            if (steel.Count > 0)
            {
                Console.WriteLine($"Steel left: {string.Join(", ", steel)}");
            }
            else
            {
                Console.WriteLine("Steel left: none");
            }

            if (carbon.Count > 0)
            {
                Console.WriteLine($"Carbon left: {string.Join(", ", carbon)}");
            }
            else
            {
                Console.WriteLine("Carbon left: none");
            }


            if (broadsword > 0)
            {
                Console.WriteLine($"Broadsword: {broadsword}");
            }
            if (gladius > 0)
            {
                Console.WriteLine($"Gladius: {gladius}");
            }
            if (katana > 0)
            {
                Console.WriteLine($"Katana: {katana}");
            }
            if (sabre > 0)
            {
                Console.WriteLine($"Sabre: {sabre}");
            }
            if (shamshir > 0)
            {
                Console.WriteLine($"Shamshir: {shamshir}");
            }
        }
    }
}
