using EntityFramework.Data;
using EntityFramework.Models;
using System;
using System.Linq;
using System.Text;

namespace EntityFramework
{
    internal class StartUp
    {
        static void Main(string[] args)
        {
            SoftUniContext db = new SoftUniContext();

            string result = GetEmployeesFullInformation(db);

            Console.WriteLine(result);
        }

        public static string GetEmployeesFullInformation(SoftUniContext context)
        {
            StringBuilder sb = new StringBuilder();

            Employee[] employees = context.Employees.OrderBy(e => e.AddressId).ToArray();

            foreach (Employee e in employees)
            {
                sb.AppendLine($"{e.FirstName} {e.LastName} {e.MiddleName} {e.JobTitle} {e.Salary:f}");
            }

            return sb.ToString().TrimEnd();
        }
    }
}
