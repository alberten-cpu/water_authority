from doctest import debug

from flask import Flask, render_template, request, session, redirect, flash
from flask.sessions import SecureCookieSession

from DBConnection import Db
from datetime import datetime
import requests

app = Flask(__name__, template_folder='template', static_url_path='/static/')
app.secret_key = "asdff"

@app.route('/')
def ind():
    return render_template("/waterboat/index.html")


@app.route('/l')
def login():
    return render_template("login.html")


@app.route('/adminhome')
def Adminhome():
    if session.get('lid'):
        return render_template("Adminhome.html")
    else:
        return login()

@app.route('/branchhome')
def Branchhome():
    return render_template("BranchHome.html")

@app.route('/Emphome')
def Emphome():
    return render_template("EmployeHome.html")



@app.route('/login1', methods=['post'])
def login1():
    name = request.form['un']
    password = request.form['pass']
    qry = "select * from login where username='" + name + "' and password='" + password + "'"
    ob = Db()
    print(qry)
    res = ob.selectOne(qry)
    print(res)
    if res is not None:
        role = res['role']
        session['lid'] = res['username']
        # login=session['lid']
        print(login1)
        if role == 'admin':
            return Adminhome()
        elif role == 'branch':
            return Branchhome()
        elif role == 'employe':
            return Emphome()
        else:
             return "<script>alert('invalid');window.location='/';</script>"
    else:
        return "<script>alert('Invalid');window.location='/';</script>"


@app.route('/logout')
def logout():
    s=SecureCookieSession()
    s.clear()
    session.clear()
    return login()

# -----------------------------------ADMIN---------------------------------------#


@app.route('/branch_reg')
def register():
    if session.get('lid'):
        return render_template("admin/AddBranch.html")
    else:
        return login()



# Add Branch
@app.route('/branch_registration', methods=["post"])
def registration():
    if session.get('lid'):
        brid = request.form['TxtBranchid']
        address = request.form['TxtAddress']
        phone = request.form['TxtPhone']
        email = request.form['TxtEmail']
        passw = request.form['TxtPassword']
        ob = Db()

        q = "insert into login values(null,'" + brid + "','" + passw + "','branch')"
        ob.insert(q)

        q = "insert into branch_pincode values(null,'" + brid + "','0')"
        lid = ob.insert(q)

        q = "insert into branch values ('" + brid + "','" + address + "','" + phone + "','" + email + "','" + passw + "')"
        ob.insert(q)

        return Adminhome()
    else:
        return login()


@app.route('/AdminViewBranch', methods=["get"])
def AdminViewBranch():
    if session.get('lid'):
        obj = Db()

        data = None

        res = obj.select("select * from branch ")
        if res:
            data = res

        if data == None:
            return '''  <script>  alert('no any data found');window.location='/home'</script> '''

        return render_template("/admin/AdminViewBranch.html", data=res)
    else:
        return login()


@app.route('/branch_dele/<branch_id>')
def branch_del(branch_id):
    if session.get('lid'):
        db = Db()
        res = db.delete("delete from branch where branch_id='" + str(branch_id) + "'")
        re = db.delete("delete from login where username='" + str(branch_id) + "' ")
        re = db.delete("delete from branch_pincode where branch_id='" + str(branch_id) + "' ")
        return AdminViewBranch()
    else:
        return login()


@app.route('/EditBranch/<branch_id>')
def edit(branch_id):
    if session.get('lid'):
        db = Db()
        re = db.selectOne("select * from branch where branch_id = '" + str(branch_id) + "' ")
        return render_template("admin/AdminEditBranch.html", data=re, vid=str(branch_id))
    else:
        return login()



@app.route('/UpdateBranch/', methods=["post"])
def updates():
    if session.get('lid'):
        branchid = request.form['id']
        add = request.form['address']
        ph = request.form['phone']
        em = request.form['email']
        pas = request.form['password']
        ob = Db()

        qq = "update branch set branch_id='" + branchid + "',address='" + add + "',phone='" + ph + "',email='" + em + "',password='" + pas + "' where branch_id='" + str(
            branchid) + "' "
        ob.update(qq)
        return AdminViewBranch()
    else:
        return login()


@app.route('/AdminViewPincode', methods=["get"])
def AdminViewPin():
    if session.get('lid'):
        obj = Db()

        data = None

        res = obj.select("select * from branch_pincode ")
        if res:
            data = res

        if data == None:
            return '''  <script>  alert('no any data found');window.location='/home'</script> '''

        return render_template("/admin/AdminViewBranchPin.html", data=res)
    else:
        return login()

@app.route('/EditPin/<branch_id>')
def editpin(branch_id):
    if session.get('lid'):
        db = Db()
        re = db.selectOne("select * from branch_pincode where branch_id = '" + str(branch_id) + "' ")
        return render_template("admin/EditPin.html", data=re, vid=str(branch_id))
    else:
        return login()


@app.route('/UpdatePin/', methods=["post"])
def UpdatePin():
    if session.get('lid'):
        branchid = request.form['id']
        branchpin = request.form['pin']

        ob = Db()

        qq = "update branch_pincode set pincode='" + branchpin + "' where branch_id='" + str(branchid) + "' "
        ob.update(qq)
        return AdminViewPin()
    return login()


@app.route('/AdminViewUnitPrice', methods=["get"])
def AdminViewUnitPrice():
    if session.get('lid'):
        obj = Db()

        data = None

        res = obj.select("select * from unit_price ")
        if res:
            data = res

        if data == None:
            q = "insert into unit_price values(null,'0')"
            obj.insert(q)
        return render_template("/admin/AdminViewUnitPrice.html", data=res)
    else:
        return login()


@app.route('/UpdateUnitPrice/', methods=["post"])
def UpdateUnitPrice():
    if session.get('lid'):
        unpri = request.form['unpr']
        uid = request.form['uid']
        ob = Db()

        qq = "update unit_price set h_price='" + unpri + "' where unit_price_id='" + str(uid) + "' "
        ob.update(qq)
        return AdminViewUnitPrice()
    else:
        return login()


@app.route('/AdminViewSugg', methods=["get"])
def AdminViewSugg():
    if session.get('lid'):
        obj = Db()

        data = None

        res = obj.select("select * from suggestion where reply='pending' ")
        if res:
            data = res

            if data == None:
                return '''  <script>  alert('Not published any resutls for you');window.location='/home3'</script> '''

        return render_template("/admin/AdminViewSugge.html", data=res)
    else:
        return login()


@app.route('/AdminEditSg/<int:suggestion_id>')
def AdminEditSg(suggestion_id):
    if session.get('lid'):
        db = Db()
        re = db.selectOne("select * from suggestion where suggestion_id = '" + str(suggestion_id) + "' ")
        return render_template("admin/AdminReplySugg.html", data=re, vid=str(suggestion_id))
    else:
        return login()


@app.route('/AdminRplySugg/', methods=["post"])
def AdminRplySugg():
    if session.get('lid'):
        idd = request.form['iid']
        reply = request.form['reply']
        # today = date.today()
        ob = Db()
        date = datetime.now()

        print('Current Timestamp : ', date)
        qq = "update suggestion set reply='" + reply + "',reply_date='" + str(date) + "' where suggestion_id='" + str(
            idd) + "' "
        ob.update(qq)
        return AdminViewSugg()
    else:
        return login()


# -----------------------------------BRANCH---------------------------------------#

# Add employe
@app.route('/emp_reg')
def empregister():
    return render_template("branch/AddEmploye.html")


@app.route('/employe_registration', methods=["post"])
def empregistration():
    empid = request.form['id']
    name = request.form['name']
    address = request.form['address']
    phone = request.form['phone']
    desig = request.form['desig']
    passw = request.form['pass']
    brid = session['lid']
    ob = Db()

    q = "insert into login values(null,'" + empid + "','" + passw + "','employe')"
    ob.insert(q)

    q = "insert into emp_assign_area values(null,'" + empid + "','0','" + brid + "')"
    lid = ob.insert(q)

    q = "insert into employee values ('" + empid + "','" + name + "','" + address + "','" + phone + "','" + desig + "','" + str(
        brid) + "','" + passw + "')"
    ob.insert(q)

    return Branchhome()


@app.route('/BranchViewEmploye', methods=["get"])
def BranchViewEmp():
    obj = Db()

    data = None

    res = obj.select("select * from employee ")
    if res:
        data = res

    if data == None:
        return '''  <script>  alert('no any data found');window.location='/BranchHome'</script> '''

    return render_template("/branch/BranchViewEmp.html", data=res)


@app.route('/emp_del/<emp_id>/<name>')
def empdel(emp_id, name):
    db = Db()
    res = db.delete("delete from  employee where emp_id='" + str(emp_id) + "' ")
    re = db.delete("delete from login where username='" + str(emp_id) + "' and role='employe' ")
    return BranchViewEmp()


@app.route('/EditEmp/<emp_id>/')
def empedit(emp_id):
    db = Db()
    re = db.selectOne("select * from employee where emp_id = '" + str(emp_id) + "' ")
    return render_template("branch/EditEmp.html", data=re, vid=str(emp_id))


@app.route('/UpdateEmp/', methods=["post"])
def brempupdate():
    empid = request.form['id']
    name = request.form['name']
    add = request.form['address']
    ph = request.form['phone']
    de = request.form['desig']
    pas = request.form['password']
    ob = Db()

    qq = "update employee set name='" + name + "',address='" + add + "',contact='" + ph + "',designation='" + de + "',password='" + pas + "' where emp_id='" + str(
        empid) + "' "
    q = "update login set password='" + pas + "' where username='" + str(empid) + "' and role='employe' "
    ob.update(qq)
    ob.update(q)
    return BranchViewEmp()


@app.route('/BranchViewPin', methods=["get"])
def BranchViewPin():
    obj = Db()

    data = None

    res = obj.select("select * from emp_assign_area ")
    if res:
        data = res

    if data == None:
        return '''  <script>  alert('no any data found');window.location='/BranchHome'</script> '''

    return render_template("/branch/ViewEmpPin.html", data=res)


@app.route('/EditEmpPin/<emp_id>/')
def emppinedit(emp_id):
    db = Db()
    re = db.selectOne("select * from emp_assign_area where emp_id = '" + str(emp_id) + "' ")
    return render_template("branch/EditEmpPin.html", data=re, vid=str(emp_id))


@app.route('/UpdateEmpPin/', methods=["post"])
def UpdateEmpPin():
    id = request.form['id']
    pin = request.form['pin']
    ob = Db()

    qq = "update emp_assign_area set pincode='" + pin + "' where emp_id='" + str(id) + "' "
    ob.update(qq)
    return BranchViewPin()


@app.route('/BranchViewComplaint', methods=["get"])
def BranchViewCmp():
    obj = Db()

    data = None

    res = obj.select("select * from complaints ")
    if res:
        data = res

    if data == None:
        return '''  <script>  alert('no any data found');window.location='/BranchHome'</script> '''

    return render_template("/branch/BranchViewCmplnt.html", data=res)


@app.route('/consuReg')
def ConsumerReg():
    return render_template("branch/AddConsumer.html")


@app.route('/ConsumerReg', methods=["post"])
def consumerReg():
    cno = request.form['conno']
    name = request.form['name']
    add = request.form['add']
    dob = request.form['dob']
    pin = request.form['pin']
    area = request.form['area']
    city = request.form['city']
    phone = request.form['phone']
    mobile = request.form['mobile']
    mail = request.form['mail']
    pa = request.form['pass']
    ob = Db()

    q = "insert into login values(null,'" + cno + "','" + pa + "','consumer')"
    ob.insert(q)

    q = "insert into consumer values ('"+cno+"','" + name + "','" + add + "','" + dob + "','" + pin + "','" + area + "','" + city + "','" + phone + "','" + mobile + "','" + mail+"','registered','"+pa+"')"

    ob.insert(q)

    return Branchhome()


@app.route('/BranchViewConsumer', methods=["get"])
def BranchViewConsu():
    obj = Db()

    data = None

    res = obj.select("select * from consumer where con_status='registered'  ")
    if res:
        data = res

    if data == None:
        return '''  <script>  alert('no any data found');window.location='/BranchHome'</script> '''

    return render_template("/branch/BranchViewConsumer.html", data=res)


@app.route('/Consumer_del/<consumer_no>/<cname>')
def consumerdel(consumer_no, cname):
    db = Db()
    res = db.delete("delete from  consumer where consumer_no='" + str(consumer_no) + "' and cname='"+str(cname)+"' ")
    re = db.delete("delete from login where username='" + str(consumer_no) + "' and role='consumer' ")
    print(res)
    return BranchViewConsu()


@app.route('/Consumer_edit/<consumer_no>/<cname>/')
def consumeredit(consumer_no,cname):
    db = Db()
    re = db.selectOne("select * from consumer where consumer_no = '" + str(consumer_no) + "' and cname='" + str(cname) + "' ")
    return render_template("branch/EditConsumer.html", data=re, cno=str(consumer_no))


@app.route('/ConsumerUpdate/', methods=["post"])
def consumerupdate():

    cno = request.form['cno']
    name = request.form['name']
    add = request.form['add']
    dob = request.form['dob']
    pin = request.form['pin']
    area = request.form['area']
    city = request.form['city']
    phone = request.form['phone']
    mobile = request.form['mob']
    mail = request.form['mail']
    pa = request.form['pas']
    ob = Db()

    qq = "update consumer set cname='" + name + "',address='" + add + "',dob='" + dob + "',pincode='" + pin + "',area='" + area + "',city='" + city + "',phone='" + phone + "',mobile='" + mobile + "',email='" + mail + "',password='" + pa + "' where consumer_no='" + str(
        cno) + "' and cname = '"+name+"' "
    q = "update login set password='" + pa + "' where username='" + str(cno) + "' and role='consumer'"
    ob.update(qq)
    ob.update(q)
    return BranchViewConsu()


@app.route('/searchConsu')
def searchconsu():
    obj=Db()
    data1 = None
    qry="select * from consumer"
    res=obj.select(qry)

    return render_template("branch/SearchConsumer.html",data=res,data1 = data1)



@app.route('/searchconsumer', methods=['POST'])
def searchconsumer():

    cno = request.form['company_id']
    #print(conno)

    data1 = None

    obj = Db()
    res = obj.select("select * from consumer where consumer_no= '" +cno + "'  ")

    if res:
        data11 = res

    # print(data11)
        return render_template("branch/SearchConsumer.html", data1 = data11)
    else:
        return '''<script>alert("Result is not yet published");window.location='/Branchhome'</script>'''


@app.route('/waterfailurealert')
def waterfailurealert():
    return render_template("branch/waterFailure.html")


@app.route('/waterfailure', methods=["post"])
def waterfailure():
    branchid = session['lid']
    date = request.form['date']
    fromdate = request.form['from']
    to = request.form['to']
    description = request.form['why']

    ob = Db()

    q = "insert into water_failure values(null,'" + branchid + "','" + date + "','" + fromdate + "','" + to + "','" + description + "')"
    ob.insert(q)
    return Branchhome()


#------------------------------------------Employe  _-----------------------------------#


@app.route('/EmpViewComplaint', methods=["get"])
def EmpViewComplaint():
    obj = Db()

    data = None

    res = obj.select("select * from complaints where status  ='pending' ")
    if res:
        data = res

    if data == None:
        return '''  <script>  alert('no any data found');window.location='/Emphome'</script> '''

    return render_template("/employe/EmpViewComplaint.html", data=res)


@app.route('/complaint_reply/<comp_no>/<consumer_no>/')
def complaint_reply(comp_no,consumer_no):
    db = Db()
    re = db.selectOne("select * from complaints where consumer_no = '" + str(consumer_no) + "' and comp_no='" + str(comp_no) + "' ")
    return render_template("employe/ReplyComplaint.html", data=re, cno=str(consumer_no))


@app.route('/complaintupdate/', methods=["post"])
def complaintupdate():

    compno = request.form['compno']
    consumerno = request.form['consuno']
    reply = request.form['reply']
    ob = Db()

    qq = "update complaints set reply='" + reply + "',status = 'replied' where comp_no='" + compno + "' and consumer_no = '"  + consumerno+ "' "

    ob.update(qq)

    return Emphome()




#-------------------------------------------------------------------------------------------------------------------#
@app.route('/forgpass/')
def forgpass():
    db = Db()
    return render_template("forgpass.html")

@app.route('/checkpass', methods=['post'])
def checkpass():
    name = request.form['un']
    role = request.form['ro']
    qry = "select * from login where username='" + name + "' and role='" + role + "'"
    ob = Db()
    print(qry)
    res = ob.selectOne(qry)
    print(res)
    if res is not None:
        return render_template("updatepass.html" ,data=res)

    else:
        return "<script>alert('Invalid');window.location='/';</script>"


@app.route('/passupdate', methods=["post"])
def passupdate():

    pas = request.form['pas']
    passw = request.form['pa']
    id = request.form['id']
    uname = request.form['uname']
    ob = Db()
    if pas == passw:
        qq = "update login set password='" + pas + "'  where login_id='" + id + "' and username = '"  + uname+ "' "

        ob.update(qq)
        return render_template("login.html")
    else:
        return "<script>alert('Invalid');window.location='/forgpass';</script>"



if __name__ == '__main__':
    app.run(debug=True)
