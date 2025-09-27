using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentManagement.Model
{
    internal class Student
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string EnrollmentDate { get; set; }

        public Student(int id, string firstName, string lastName, string email, string enrollmentDate)
        {
            Id = id;
            FirstName = firstName;
            LastName = lastName;
            Email = email;
            EnrollmentDate = enrollmentDate;
        }
    }
}
