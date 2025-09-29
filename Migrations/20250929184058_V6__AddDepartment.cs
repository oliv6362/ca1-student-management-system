using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudentManagement.Migrations
{
    /// <inheritdoc />
    public partial class V6__AddDepartment : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Enrollment_Instructor_InstructorId",
                table: "Enrollment");

            migrationBuilder.DropIndex(
                name: "IX_Enrollment_InstructorId",
                table: "Enrollment");

            migrationBuilder.DropColumn(
                name: "InstructorId",
                table: "Enrollment");

            migrationBuilder.CreateTable(
                name: "Department",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DepartmentHeadId = table.Column<int>(type: "int", nullable: true),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Budget = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: false),
                    StartDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Department", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Department_Instructor_DepartmentHeadId",
                        column: x => x.DepartmentHeadId,
                        principalTable: "Instructor",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Department_DepartmentHeadId",
                table: "Department",
                column: "DepartmentHeadId",
                unique: true,
                filter: "[DepartmentHeadId] IS NOT NULL");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Department");

            migrationBuilder.AddColumn<int>(
                name: "InstructorId",
                table: "Enrollment",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Enrollment_InstructorId",
                table: "Enrollment",
                column: "InstructorId");

            migrationBuilder.AddForeignKey(
                name: "FK_Enrollment_Instructor_InstructorId",
                table: "Enrollment",
                column: "InstructorId",
                principalTable: "Instructor",
                principalColumn: "Id");
        }
    }
}
