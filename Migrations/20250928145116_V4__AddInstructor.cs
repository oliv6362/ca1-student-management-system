using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudentManagement.Migrations
{
    /// <inheritdoc />
    public partial class V4__AddInstructor : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "InstructorId",
                table: "Enrollment",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "InstructorId",
                table: "Course",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "Instructor",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirstName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LastName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    HireDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Instructor", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Enrollment_InstructorId",
                table: "Enrollment",
                column: "InstructorId");

            migrationBuilder.CreateIndex(
                name: "IX_Course_InstructorId",
                table: "Course",
                column: "InstructorId");

            migrationBuilder.AddForeignKey(
                name: "FK_Course_Instructor_InstructorId",
                table: "Course",
                column: "InstructorId",
                principalTable: "Instructor",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Enrollment_Instructor_InstructorId",
                table: "Enrollment",
                column: "InstructorId",
                principalTable: "Instructor",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Course_Instructor_InstructorId",
                table: "Course");

            migrationBuilder.DropForeignKey(
                name: "FK_Enrollment_Instructor_InstructorId",
                table: "Enrollment");

            migrationBuilder.DropTable(
                name: "Instructor");

            migrationBuilder.DropIndex(
                name: "IX_Enrollment_InstructorId",
                table: "Enrollment");

            migrationBuilder.DropIndex(
                name: "IX_Course_InstructorId",
                table: "Course");

            migrationBuilder.DropColumn(
                name: "InstructorId",
                table: "Enrollment");

            migrationBuilder.DropColumn(
                name: "InstructorId",
                table: "Course");
        }
    }
}
