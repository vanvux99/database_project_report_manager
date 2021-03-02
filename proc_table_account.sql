
-- luôn luôn gọi tới db đang muốn sử dụng
use REPORT_MANAGER
go

-- đặt tên proc: 
-- proc_<chức năng>_<tên bảng>
create procedure proc_CRUD_accounts
	-- type data phải trùng với data type đã tạo trong file table.sql
	-- các đối số luôn phải đặt là null, tiết kiệm thời gian nhập dữ liệu 
	@select int = null, -- select này để phân các chức năng như  search, insert, update, delete...
	@tittle_search nvarchar(max) = null,

	@id varchar(100) = null,
	@username varchar(20) = null,
	@passwords varchar(20) = null,
	@age int = null,
	@addresss nvarchar(max) = null,
	@roles nvarchar(20) = null,
	@first_name nvarchar(100) = null,
	@last_name nvarchar(100) = null,
	@mail varchar(50) = null,
	@sex nvarchar(20) = null
as 
begin
	if(@select = 1) -- search by username
	begin 
		select * 
		from accounts
		where username like '%' + @tittle_search + '%'

		select 'search'
	end
	
	if(@select = 2)	-- insert
	begin 
		insert into accounts
		(
			id,
			username,
			passwords,
			age,
			addresss,
			roles,
			first_name,
			last_name,
			mail,
			sex
		)
		values 
		(
			@id,
			@username,
			@passwords,
			@age,
			@addresss,
			@roles,
			@first_name,
			@last_name,
			@mail,
			@sex
		)

		if @@rowcount > 0 -- rowcount: kiểm tra thay đổi trong bảng, nếu nó có thay đổi thì trả về 1 table[0][0] = 'insert'
			select 'insert'
		else 
			select 'bảng chưa được thêm mới'
	end

	if(@select = 3) -- update
	begin 
		update accounts
		set
			username = @username,
			passwords = @passwords,
			age = @age,
			addresss = @addresss,
			roles = @roles,
			first_name = @first_name,
			last_name = @last_name,
			mail = @mail,
			sex = @sex
		where id = @id

		if @@rowcount = 0
			print 'bảng chưa được cập nhật'

		select 'update'
	end

	if(@select = 4) -- delete
	begin 
		delete from accounts
		where id = @id

		select 'delete'
	end

	if(@select = 5) --select all
	begin 
		select * 
		from accounts

		select 'select all'
	end
end
go

--===================================================

-- thêm dữ liệu cho bảng account
exec proc_CRUD_accounts 
	@select = 2,
	@id = 1,
	@username = 'vux',
	@passwords = 'vux',
	@age = 21,
	@addresss = 'thái bềnh',
	@roles = 'admin',
	@first_name = 'vu',
	@last_name = 'doan',
	@mail = 'vanvux99@gmail.com',
	@sex = 'Nam'
go

exec proc_CRUD_accounts 
	@select = 2,
	@id = 2,
	@username = 'vux',
	@passwords = 'vux',
	@age = 21,
	@addresss = 'thái bình',
	@roles = 'user',
	@first_name = 'vu',
	@last_name = 'doan',
	@mail = 'vanvux999@gmail.com',
	@sex = 'Nam'
go

exec proc_CRUD_accounts 
	@select = 2,
	@id = 3,
	@username = 'vux',
	@passwords = 'vux',
	@age = 21,
	@addresss = 'thái bình',
	@roles = 'user siêu cấp vip pro',
	@first_name = 'vu',
	@last_name = 'doan',
	@mail = 'vanvux9999@gmail.com',
	@sex = 'Nam'
go

exec proc_CRUD_accounts 
	@select = 2,
	@id = 4,
	@username = 'vux',
	@passwords = 'vux',
	@age = 21,
	@addresss = 'thái bình',
	@roles = 'user siêu cấp vip pro',
	@first_name = 'vu',
	@last_name = 'doan',
	@mail = 'vanvux9999@gmail.com',
	@sex = 'Nam'
go
