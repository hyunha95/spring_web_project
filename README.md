# spring_web_project   

part6
===
첨부파일을 서버에 전송하는 방식은 크게   
   \<form\>태그를 이용해서 업로드하는 방식
   Ajax를 이용하는 방식   
   
- \<form\> 태그를 이용하는 방식: 브라우저의 제한이 없어야 하는 경우에 사용   
   일반적으로 페이지 이동과 동시에 첨부파일을 업로드하는 방식   
   \<iframe\>을 이용해서 화면의 이동 없이 첨부파일을 처리하는 방식   
- Ajax를 이용하는 방식: 첨부파일을 별도로 처리하는 방식     
   \<input type='file'\>을 이용하고 Ajax로 처리하는 방식   
   HTML5의 Drag And Drop 기능이나 jQuery 라이브러리를 이용해서 처리하는 방식   
   
Part5
===
AOP(Aspect-Oriented Programming)는 '관점 지향 프로그래밍'이라는 의미로 번역되는데, 객체지향에서 특정 비즈니스 로직에 걸림돌이 되는 공통 로직을 제거할 수 있는 방법을 제공한다. AOP를 적용하면 기존의 코드에 첨삭 없이, 메소드의 호출 이전 혹은 이후에 필요한 로직을 수행하는 방법을 제공한다.   
트랜잭션 작업은 데이터베이스를 이용할 때 '두 개 이상의 작업이 같이 영향을 받는 경우에'에 필요하다. 과거에는 코드 내에 개발자가 직업 이를 지정하고 사용했다면 스프링에서는 XML이나 어노테이션만으로 트랜잭션이 결과를 만들어 낼 수 있다.   
   
![image](https://user-images.githubusercontent.com/76119021/161429626-4930e165-49cf-4af9-9912-9b125de0c589.png)   
개발자의 입장에서 AOP를 적용한다는 것은 기존의 코드를 수정하지 않고도 원하는 관심사(cross-concern)들을 엮을 수 있다는 점이다. 위의 그림에서 Target에 해당하는 것이 바로 개발자가 작성한 핵심 비즈니스 로직을 가지는 객체이다.Target은 순수한 비즈니스 로직을 의미하고, 어떠한 관심사들과도 관계를 맺지 않는다.   
   
Target을 전체적으로 감싸고 있는 존재를 Proxy라고 한다. Proxy는 내부적으로 Target을 호출하지만, 중간에 필요한 관심사들을 거쳐서 Target을 호출하도록 자동 혹은 수동으로 작성된다. Proxy의 존재는 직접 코드를 통해서 구현하는 경우도 있지만, 대부분의 경우 스프링 AOP 기능을 이용해서 자동으로 생성되는(auto-proxy) 방식을 이용한다.   
   
JoinPoint는 Target 객체가 가진 메서드이다. 외부에서의 호출은 Proxy 객체를 통해서 Target 객체의 JoinPoint를 호출하는 방식이라고 이해할 수 있다.   
   
JoinPoint는 Target이 가진 여러 메서드라고 보면 된다(엄밀하게 스프링 AOP에서는 메서드만이 JoinPoint가 된다.). Target에는 여러 메서드가 존재하기 때문에 어떤 메서드에 관심사를 결합할 것인지를 결정해야 하는데 이 결정을 'Pointcut'이라고 한다.   
   
Pointcut은 관심사와 비즈니스 로직이 결합되는 지점을 결정하는 것이다.   
   
관심사(concern)는 Aspect와 Advice라는 용어로 표현되어 있다. Aspect는 조금 추상적인 개념을 의미한다. Aspect는 관심사 자체를 의미하는 추상명사라고 볼 수 있고, Advice는 Aspect를 구현한 코드이다. Advice는 실제 걱정거리를 분리해 놓은 코드를 의미한다. Advice는 그 동작 위치에 따라 다음과 같이 구분된다.   
- Before Advice: Target의 JoinPoint를 호출하기 전에 실행되는 코드이다. 코드의 실행 자체에는 관여할 수 없다.   
- After Returning Advice: 모든 실행이 정상적으로 이루어진 후에 동작하는 코드이다.   
- After Throwing Advice: 예외가 발생한 뒤에 동작하는 코드이다.   
- After Advice: 정상적으로 실행되거나 예외가 발생했을 때 구분 없이 실행되는 코드이다.   
- Around Advice: 메서드의 실행 자체를 제어할 수 있는 가장 강력한 코드이다. 직접 대상 메서드를 호출하고 결과나 예외를 처리할 수 있다.   
   
Pointcut은 Advice를 어떤 JoinPoint에 결합할 것인지를 결정하는 설정이다. AOP에서 Target은 결과적으로 Pointcut에 의해서 자신에게는 없는 기능들을 가지게 된다. Pointcut은 다양한 형태로 선언해서 사용할 수 있느데 주로 사용되는 설정은 다음과 같다.   
- execution(@execution): 메서드를 기준으로 Pointcut을 설정한다.   
- within(@within): 특정한 타입(클래스)을 기준으로 Pointcut을 설정한다.   
- this: 주어진 인터페이스를 구현한 객체를 대상으로 Pointcut을 설정한다.   
- args(@args): 특정한 파라미터를 가지는 대상들만을 Pointcut으로 설정한다.   
- @annotation: 특정한 어노테이션이 적용된 대상들만을 Pointcut으로 설정한다.   
   
AOP 설정과 관련해서 가장 중요한 라이브러리는 AspectJ Weaver라는 라이브러리이다. 스프링은 AOP 처리가 된 객체를 생성할 때 AspectJ Weaver 라이브러리의 도움을 받아서 동작하므로, pom.xml에 추가해야 한다.   
   
@Aspect는 해당 클래스의 객체가 Aspect를 구현한 것임을 나타내기 위해서 사용한다. @Component는 AOP와는 관계가 없지만 스프링에서 빈(bean)으로 인식하기 위해서 사용한다. @Before는 BeforeAdvie를 구현한 메서드에 추가한다. @After, @AfterReturning, @AfterThrowing, @Around 역시 동일한 방식으로 적용한다.   
Advice와 관련된 어노테이션들은 내부적으로 Pointcut을 지정한다. Pointcut은 별도의 @Pointcut으로 지정해서 사용할 수도 있다. @Before내부의 'execution....' 문자열은 AspectJ의 표현식(expression)이다. 'execution'의 경우 접근제한자와 특정 클래스의 메서드를 지정할 수 있다. 맨 앞의 '\*'는 접근제한자를 의미하고, 맨 뒤의 '\*'는 클래스의 이름과 메서드의 이름을 의미한다.   
   
스프링 프로젝트에 AOP를 설정하는 것은 스프링 2버전 이후에는 간단히 자동으로 Proxy 객체를 만들어주는 설정을 추가해 주면 된다. 프로젝트의 root-context.xml을 선택해서 네임스페이스에 'aop'와 'context'를 추가한다.   
root-context.xml에 아래와 같은 내용을 추가한다.   
```xml
<context:annotation-config></context:annotation-config>
	
<context:component-scan base-package="org.zerock.service"></context:component-scan>
<context:component-scan base-package="org.zerock.aop"></context:component-scan>

<aop:aspectj-autoproxy></aop:aspectj-autoproxy>
```   
root-context.xml에서는 <component-scan>을 이용해서 'org.zerock.service'패키지와 'org.zerock.aop'패키지를 스캔한다. 이 과정에서 SampleServiceImpl 클래스와 LogAdvice는 스프링의 빈(객체)으로 등록될 것이고, <aop:aspectj-autoproxy>를 이용해서 LogAdvice에 설정한 @Before가 동작하게 된다.   
   
args를 이용한 파라미터 추적
---
```java
@Before("execution(* org.zerock.service.SampleService*.doAdd(String,String)) && args(str1, str2)")
public void logBeforeWithParam(String str1, String str2){
   log.info("str1: " + str1);
   log.info("str2: " + str2);
}
```   
logBeforeWithParam()에서는 'execution'으로 시작하는 Pointcut 설정에 doAdd()메서드를 명시하고, 파라미터의 타입을 지정했다. 뒤쪽의 '&& args(...' 부분에는 변수명을 지정하는데, 이 2종류의 정보를 이용해서 logBeforeWithParam() 메서드의 파라미터를 설정하게 된다.   
'&& args'를 이용하는 설정은 간단히 파라미터를 찾아서 기록할 때에는 유용하지만 파라미터가 다른 여러 종류의 메서드에 적용하는 데에는 간단하지 않다는 단점이 있다. 이에 대한 문제는 @Around와 ProceedingJoinPoint를 이용해서 해결할 수 있다.   
   


part4
===
Note
---
흔히 URL(Uniform Resource Locator)과 URI(Uniform Resource Identifier)를 같은 의미로 사용하는 경우가 많다. 엄밀하게는 URL은 URI의 하위 개념이기 때문에 혼용해도 무방하다. URI는 '자원의 식별자'라는 의미로 사용된다.   
URL은 '이 곳에 가면 당신이 원하는 것을 찾을 수 있습니다.'와 같은 상징적인 의미가 좀 더 강하다면, URI는 '당신이 원하는 곳의 주소는 여기입니다.'와 같이 좀 더 현실적이고 구체적인 의미가 있다. URI의 'I'는 마치 데이터베이스의 PK와 같은 의미로 사용된다고 생각할 수 있다.   
JSON은 'JavaScript Object Notation'의 약어로 구조가 있는 데이터를 '{ }'로 묶고 '키'와 '값'으로 구성하는 경량의 데이터 포맷이다.   

Rest 방식으로 전환
---
REST 'Representational State Transfer'의 약어로 하나의 URI는 하나의 고유한 리소스(Resource)를 대표하도록 설계된다는 개념에 전송방식을 결합해서 원하는 작업을 지정한다.   
스프링은 @RequestMapping이나 @ResponseBody와 같이 REST 방식의 데이터 처리를 위한 여러 종류의 어노테이션과 기능이 있다.   
- @RestController: Controller가 REST 방식을 처리하기 위한 것임을 명시한다.
- @ResponseBody: 일반적인 JSP와 같은 뷰로 전달되는 게 아니라 데이터 자체를 전달하기 위한 용도
- @PathVariable: URL 경로에 있는 값을 파라미터로 추출하려고 할 때 사용
- @CrossOrigin: Ajax의 크로스 도메인 문제를 해결해주는 어노테이션
- @RequestBody: JSON 데이터를 원하는 타입으로 바인딩 처리

@RestController
---
REST 방식에서 가장 먼저 기억해야 하는 점은 서버에서 전송하는 것이 순수한 데이터라는 점이다. 기존의 Controller에서 Model에 데이터를 담아서 JSP 등과 같은 뷰(View)로 전달하는 방식이 아니므로 기존의 Controller와는 조금 다르게 동작한다.   
스프링 4에서부터는 @Controller 외에 @RestController라는 어노테이션을 추가해서 해당 Controller의 모든 메서드의 리턴 타입을 기존과 다르게 처리한다는 것을 명시한다. @RestController 이전에는 @Controller와 메서드 선언부에 @ResponseBody를 이용해서 동일한 결과를 만들 수 있었다. @RestController는 메서드의 리턴 타입으로 사용자가 정의한 클래스 타입을 사용할 수 있고, 이를 JSON이나 XML로 자동으로 처리할 수 있다.   
   
jackson-databind 라이브러리는 나중에 브라우저에 객체를 JSON이라는 포맷의 문자열로 변환시켜 전송할 때 필요하다.   
XML의 처리는 jackson-dataformat-xml 라이브러리를 이용한다.   
직접 Java 인스턴스를 JSON 타입의 문자열로 변환해야 하는 일들도 있으므로 gson 라이브러리도 추가한다.   

@RestController의 반환 타입
---
@RestController는 JSP와 달리 순수한 데이터를 반환하는 형태이므로 다양한 포맷의 데이터를 전송할 수 있다. 주로 많이 사용하는 형태는 일반 문자열이나 JSON, XML 등을 사용한다.   
기존의 @Controller는 문자열을 반환하는 경우에는 JSP 파일의 이름으로 처리하지만, @RestController의 경우에는 순수한 데이터가 된다. @GetMapping에 사용된 produces 속성은 해당 메서드가 생산하는 MIME 타입을 의미한다. 문자열로 직접 지정할 수도 있고, 메서드 내의 MediaType이라는 클래스를 이용할 수도 있다. @GetMapping이나 @RequestMapping의 produces 속성은 반드시 지정해야 하는 것은 아니므로 생략하는 것도 가능하다.   
Map을 이용하는 경우에는 '키(key)'에 속하는 데이터는 XML로 변환되는 경우에 태그의 이름이 되기 때문에 문자열을 지정한다.   

ResponseEntity 타입
---
REST 방식으로 호출하는 경우는 화면 자제가 아니라 데이터 자체를 전송하는 방식으로 처리되기 때문에 데이터를 요청한 쪽에서는 정상적인 데이터인지 비정상적인 데이터인지를 구분할 수 있는 확실한 방법을 제공해야만 한다.  
ResponseEntity는 데이터와 함께 HTTP 헤더의 상태 메시지 등을 같이 전달하는 용도로 사용한다. HTTP의 상태 코드와 에러 메시지 등을 함께 데이터를 전달할 수 있기 때문에 받는 입장에서는 확실하게 결과를 알 수 있다.   

@RestController에서 파라미터
---
@PathVariable: 일반 컨트롤러에서도 사용이 가능하지만 REST 방식에서 자주 사용된다. URL 경로의 일부를 파라미터로 사용할 때 이용.   
@RequestBody: JSON 데이터를 원하는 타입의 객체로 변환해야 하는 경우에 주로 사용   
``` java
@GetMapping("/produc/{cat}/{pid}")
public String[] getPath(
   @PathVariable("cat") String cat,
   @PathVariable("pid") Integer pid){}
```
@PathVariable을 적용하고 싶은 경우에는 '{ }'를 이용해서 변수명을 지정하고, @PathVariable을 이용해서 지정된 이름의 변숫값을 얻을 수 있다. 값을 얻을 때에는 int, double과 같은 기본 자료형은 사용할 수 없다.   
@RequestBody: @RequestBody는 전달된 요청(request)의 내용(body)을 이용해서 해당 파라미터의 타입으로 변환을 요구한다. 내부적으로 HttpMessageConverter 타입의 객체들을 이용해서 다양한 포맷의 입력 데이터를 변환할 수 있다. 대부분의 경우에는 JSON 데이터를 서버에 보내서 원하는 타입의 객체로 변환하는 용도로 사용되지만, 경우에 따라서는 원하는 포맷의 데이터를 보내고, 이를 해석해서 원하는 타입으로 사용하기도 한다.(JSON 문자열 -> Ticket 타입의 객체)   

다양한 전송방식
---
REST 방식의 데이터 교환에서 가장 특이한 점은 기존의 GET/POST 외에 다양한 방식으로 데이터를 전달한다는 점이다.   
Create -> POST   
Read -> GET   
Update -> PUT   
Delete -> DELETE   

@Param어노테이션과 댓글 목록
---   
Mybatis는 두 개 이상의 데이터를 파라미터로 전달하기 위해서는 1) 별도의 객체로 구성하거나, 2)Map을 이용하는 방식, 3) @Param을 이용해서 이름을 사용하는 방식이 있다. @Param의 속성값은 MyBatis에서 SQL을 이용할 때 '#{}'의 이름으로 사용이 가능하다.   
``` java
public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
```
XML에서 '#{bno}'가 @Param("bno")와 매칭되어서 사용되는 점에 주목해야 한다.   
   
REST 방식으로 동작하는 URL을 설계할 때는 PK를 기준으로 작성하는 것이 좋다. PK만으로 조회, 수정, 삭제가 가능하기 때문이다. 다만 댓글의 목록은 PK를 사용할 수 없기 때문에 파라미터로 필요한 게시물의 번호(bno)와 페이지 번호(page) 정보들을 URL에서 표현하는 방식을 사용한다.   
REST방식으로 처리할 때 주의해야 하는 점은 브라우저나 외부에서 서버를 호출할 때 데이터의 포맷과 서버에서 보내주는 데이터의 타입을 명확히 설계해야 하는 것이다.   
   
JavaScript의 모듈화
---   
JavaScript에서 가장 많이 사용하는 패턴 중 하나는 모듈 패턴이다. 모듈 패턴은 쉽게 말해서 관련 있는 함수들을 하나의 모듈처럼 묶음으로 구성하는 것을 의미한다. JavaScript의 클로저를 이용하는 가장 대표적인 방법이다.   
모듈 패턴은 쉽게 말해서 Java의 클래스처럼 JavaScript를 이용해서 메서드를 가지는 객체를 구성한다. 모듈 패턴은 JavaScript의 즉시 실행함수와 '{}'를 이용해서 객체를 구성한다. JavaScript의 즉시 실행함수는 () 안에 함수를 선언하고 바깥쪽에서 실행해 버린다. 즉시 실행함수는 함수의 실행 결과가 바깥쪽에 선언된 변수에 할당된다.   
``` javascript
var replyService = (function(){
   return {name:"AAAA"};
})();
```   
위의 코드에서는 replyService라는 변수에 name이라는 속성에 'AAAA'라는 속성값을 가진 객체가 할당된다.   
   
XML이나 JSON 형태로 데이터를 받을 때는 순수하게 숫자로 표현되는 시간 값이 나오게 되어 있으므로, 화면에서는 이를 변환해서 사용하는 것이 좋다.   
   
특정 댓글의 클릭 이벤트 처리
---   
DOM에서 이벤트 리스너를 등록하는 것은 반드시 해당 DOM요소가 존재해야만 가능하다. 동적으로 Ajax를 통해서 \<li\> 태그들이 만들어지면 이후에 이벤트를 등록해야 하기 떄문에 일반적인 방식이 아니라 '이벤트 위임(delegation)'의 형태로 작성해야 한다.   
'이벤트 위임'이 말은 거창하지만 실제로는 이벤트를 동적으로 생성되는 요소가 아닌 이미 존재하는 요소에 이벤트를 걸어주고, 나중에 이벤트의 대상을 변경해 주는 방식이다. jQuery는 on()을 이용해서 쉽게 처리할 수 있다.   
``` javascript
$(".chat").on("click", "li", function(e){
   var rno = $(this).data("rno");
   console.log(rno);
});
```   
jQuery에서 이벤트를 위임하는 방식은 이미 존해하는 DOM 요소에 이벤트를 처리하고 나중에 동적으로 생기는 요소들에 대해서 파라미터 형식으로 지정한다. 위의 경우 \<ul\>태그의 클래스인 'chat'을 이용해서 이벤트를 걸고 실제 이벤트의 대상은 \<li\>태그가 되도록 한다.

part3
===

스프링 MVC프로젝트의 기본 구성
---
일반적으로 웹 프로젝트는 3-tier(티어) 방식으로 구성한다.   
Presentation, Business, Persistence tier   
Presentation Tier(화면 계층)는 화면에 보여주는 기술을 사용하는 영역이다.   
Business Tier(비즈니스 계층)는 순수한 비즈니스 로직을 담고 있는 영역이다.   
Persistence Tier(영속 계층 옥은 데이터 계층)는 데이터를 어떤 방식으로 보관하고, 사용하는가에 대한 설계가 들어가는 계층이다.   
프로젝트를 3-tier로 구성하는 가장 일반적인 설명은 '유지보수'에 대한 필요성 때문이다.

Mapper 인터페이스
---
SQL을 작성할 때는 반드시 ';'이 없도록 작성해야 한다.   
SQL 뒤에 'where bno > 0' 과 같은 조건은 테이블을 검색하는데 bno라는 컬럼 조건을 주어서 Primary key(이하 PK)를 이용하도록 유도하는 조건이다.   

Mapper XML 파일
---
XML을 작성할 때는 반드시 \<mapper\>의 namespace 속성값을 Mapper인터페이스와 동일한 이름을 주는 것을 주의하고, \<select\> 태그의 id속성값은 메서드의 이름과 일치하게 작성한다. resultType 속성의 값은 select 쿼리의 결과를 특정 클래스의 객체로 만들기 위해서 설정한다. XML에 사용한 CDATA 부분은 XML에서 부등호를 사용하기 위해서 사용한다.   
Mabatis는 내부적으로 JDBC의 PreparedStatement를 활용하고 필요한 파라미터를 처리하는 '?'에대한 치환은 '#{속성}'을 이용해서 처리한다.   
insertSelectKey()는 @SelectKey라는 Mybatis의 어노테이션을 이용한다. @SelectKey는 주로 PK 값을 미리(before) SQL을 통해서 처리해 두고 특정한 이름으로 결과를 보관하는 방식이다.   
@SelectKey를 이용하는 방식은 SQL을 한 번 더 실행하는 부담이 있기는 하지만 자동으로 추가되는 PK값을 확인해야 하는 상황에서는 유용하게 사용될 수 있습니다.   
Mybatis는 Mapper 인터페이스의 리턴 타입에 맞게 select의 결과를 처리하기 때문에 tbl_board의 모든 컬럼은 BoardVO의 'bno, title, content, writer, regdate, updateDate'속성값으로 처리된다. Mybatis는 bno라는 칼럼이 존재하면 인스턴스의 'setBno()'를 호출하게 된다. Mybatis의 모든 파라미터와 리턴 타입의 처리는 get파라미터명(), set칼럼명()의 규칙으로 호출된다. 다만 #{속성}이 1개만 존재하는 경우에는 별도의 get파라미터명()을 사용하지 않고 처리된다.   
   
등록, 삭제, 수정과 같은 DML 작업은 '몇 건의 데이터가 삭제(혹은 수정)되었는지'를 반환할 수 있다.   
BoardServiceImpl 클래스에 가장 중요한 부분은 @Service라는 어노테이션이다. @Service는 계층 구조상 주로 비즈니스 영역을 담당하는 객체임을 표시하기 위해 사용한다. 작성된 어노테이션은 패키지를 읽어 들이는 동안 처리된다. 스프링 4.3부터는 단일 파라미터를 받는 생성자의 경우에는 필요한 파라미터를 자동으로 주입할 수 있다. @AllArgsConstructor는 모든 파라미터를 이용하는 생성자를 만들기 때문에 실제 코드는 BoardMapper를 주입받는 생성자가 만들어지게 된다. 비즈니스 계층의 인터페이스와 구현 클래스가 작성되었다면, 이를 스프링의 빈으로 인식하기 위해서 root-context.xml에 @Service 어노테이션이 있는 패키지를 스캔(조사)하도록 추가해야 한다.   
<context:component-scan base-package="패키지명">  

프레젠테이션(웹) 계층의 CRUD 구현
---   
WAS를 실행하지 않고 Controller를 테스트할 수 있는 방법을 알아야 한다.   
BoardController가 속한 org.zerock.controller패키지는 servlet-context.xml에 기본으로 설정되어 있으므로 별도의 설정이 필요하지 않다.   
BoardController 테스트는 스프링의 테스트 기능을 통해서 확인해 볼 수 있다. 테스트 코드는 기존과 좀 다르게 진행되는데 그 이유는 웹을 개발할 때 매번 URL을 테스트하기 위해서 Tomcat과 같은 WAS를 실행하는 불편한 단계를 생략하기 위해서이다. 스프링의 테스트 기능을 활용하면 개발 당시에 Tomcat(WAS)를 실행하지 않고도 스프링과 웹 URL을 테스트할 수 있다.   
https://github.com/hyunha95/spring_web_project/blob/3f9650cd20197ba6db09cd8c53665ccebe1e9710/ex02/src/test/java/org/zerock/controller/BoardControllerTests.java   
테스트 클래스의 선언부에는 @WebAppConfiguration 어노테이션을 적용한다. @WebAppConfiguration은 Servlet의 ServletContext를 이용하기 위해서인데, 스프링에서는 WebApplicationConetext라는 존재를 이용하기 위해서이다.   
@Before가 적용된 메소드는 모든 테스트 전에 매번 실행되는 메서드가 된다.   
MockMvc는 말 그대로 '가짜Mvc'라고 생각하면 된다. 가짜로 URL과 파라미터 등을 브라우저에서 사용하는 것처럼 만들어서 Controller를 실행해 볼 수 있다.   
MockMvc를 이용해서 파라미터를 전달할 때에는 문자열로만 처리해야 한다.   
   
리턴 시에는 'redirect:' 접두어를 사용하는데 이를 이용하면 스프링 MVC가 내부적으로 response.sendRedirect()를 처리해 주기 때문에 편리하다.   
삭제는 반드시 POST 방식으로만 처리한다.   

한글 문제와 UTF-8 필터 처리
---
새로운 게시물을 등록했을 때 만일 한글 입력에 문제가 있다는 것을 발견했다면 1) 브라우저에서 한글이 깨져서 전송되는지를 확인하고, 2) 문제가 없다면 스프링 MVC쪽에서 한글을 처리하는 필터를 등록해야 한다. web.xml에 필터 추가   

재전송(redirect) 처리
---
만일 재전송을 하지 않는다면 사용자는 브라우저의 '새로고침'을 통해서 동일한 내용을 계속 서버에 등록할 수 있기 때문에(흔히 도배하고 표현하는) 문제가 발생된다. 따라서 등록, 수정, 삭제 작업은 처리가 완료된 후 다시 동일한 내용을 전송할 수 없도록 아예 브라우저의 URL을 이동하는 방식을 이용한다. 이러한 과정에서 하나 더 신경 써야 하는 것은 브라우저에 등록, 수정, 삭제의 결과를 바로 알 수 있게 피드백을 줘야한다.   
BoardController에서 redirect 처리를 할 때 RedirectAttributes라는 특별한 타입의 객체를 이용했다. addFlashAttribute()의 경우 이러한 처리에 적합한데, 그 이유는 일회성으로만 데이터를 전달하기 때문이다(내부적으로는 HttpSession()을 이용해서 처리).   

목록 페이지
---
최근에 웹페이지들은 사용자들의 트래픽을 고려해 목록 페이지에서 새창을 뛰워서 조회 페이지로 이동하는 방식을 선호하지만 전통적인 방식에서는 현재 창 내에서 이동하는 방식을 사용한다.   
조회 페이지로의 이동은 JavaScript를 이용해서 처리할 수도 있고, \<a\> 태그를 이용해서도 처리가 가능하다. 만일 조회 페이지를 이동하는 방식이 아니라 '새창'을 통해서 보고 싶다면, \<a\>태그의 속성으로 target = '\_blank'를 지정하면 된다.   

뒤로 가기의 문제
---
'등록 -> 목록 -> 조회'까지는 순조롭지만 브라우저의 '뒤로 가기'를 선택하는 순간 다시 게시물의 등록 결과를 확인하는 방식으로 동작한다는 것이다. 이러한 문제가 생기는 원인은 브라우저에서 '뒤로 가기'나 '앞으로 가기'를 하면 서버를 다시 호출하는 게 아니라 과거에 자신이 가진 모든 데이터를 활용하기 때문이다. 브라우저에서 조회 페이지와 목록 페이지를 여러 번 앞으로 혹은 뒤로 이동해도 서버에서는 처음에 호출을 제외하고 별다른 변화가 없는 것을 확인할 수 있다. 이 문제를 해결하려면 window의 history객체를 이용해서 현재 페이지는 모달찰을 띄울 필요가 없다고 표시를 해 두는 방식을 이용해야 한다. window의 history 객체는 스택 구조로 동작   

오라클 데이터베이스 페이징 처리
===
일반적으로 페이징 처리는 크게 번호를 이용하거나 '계속 보기'의 형태로 구현된다. 번호를 이용한 페이징 처리는 과거 웹 초기부터 이어오던 방식이고, '계속 보기'는 Ajax와 앱이 등장한 이후에 '무한 스크롤'이나 '더 보기'와 같은 형태로 구현된다.   
만일 수백 만개의 데이터를 매번 정렬을 해야 하는 상황이라면 사용자는 정렬된 결과를 볼 때까지 오랜 시간을 기다려야만 하고, 특히 웹에서 동시에 여러 명의 사용자가 정렬이 필요한 데이터를 요청하게 된다면 시스템에는 많은 부하가 걸리게 되고 연결 가능한 커넥션의 개수가 점점 줄어서 서비스가 멈추는 상황을 초래하게 된다.   
빠르게 동작하는 SQL을 위해서는 먼저 order by를 이용하는 작업을 가능하면 하지 말아야 한다. order by는 데이터가 많은 경우에 엄청난 성능의 저하를 가져오기 때문에 1) 데이터가 적은 경우와 2) 정렬을 빠르게 할 수 있는 경우가 아니라면 order by는 주의해야 한다.   

order by의 문제
---
데이터베이스는 경우에 따라서 수 백만 혹은 천 만개 이상의 데이터를 처리하기 때문에 이 경우 정렬을 하게 되면 엄청나게 많은 시간과 리소스를 소모하게 된다.   

실행 계획과 order by
--- 
오라클의 페이징 처리를 제대로 이해하기 위해서 반드시 알아두어야 하는 것이 실행 계획(execution plan)이다. 실행 계획은 말 그대로 'SQL을 데이터베이스에서 어떻게 처리할 것인가?'에 대한 것이다. SQL이 데이터베이스에 전달되면 데이터베이스는 여러 단계를 거쳐서 해당 SQL을 어떤 순서와 방식으로 처리할 것인지 계획을 세우게 된다.   
데이터베이스에 전달된 SQL문은 SQL파싱 -> SQL최적화 -> SQL실행을 거쳐서 처리된다.   
SQL 파싱 단계에서는 SQL 구문에 오류가 있는지 SQL을 실행해야 하는 대상 객체(테이블, 제약 조건, 권한 등)가 존재하는지를 검사한다. 이 계산된 값을 기초로 해서 어떤 방식으로 실행하는 것이 가장 좋다는 것을 판단하는 '실행 계획(execution plan)'을 세우게 된다.   
SQL 실행 단계에서는 세워진 실행 계획을 통해서 메모리상에서 데이터를 읽거나 물리적인 공간에서 데이터를 로딩하는 등의 작업을 하게 된다.   
가장 가단하게 실행 계획을 보는 방법은 '안쪽에서 바깥쪽으로, 위에서 아래로' 봐주면 된다.   

order by 보다는 인덱스
---
데이터가 많은 상태에서 정렬 작업이 문제가 된다는 사실을 알았다면, 이 문제를 해결할 수 있는 가장 일반적인 해결책은 '인덱스(index)를 이용해서 정렬을 생략하는 방법'이다. '인덱스'라는 존재가 이미 정렬된 구조이므로 이를 이용해서 별도의 정렬을 하지 않는 방법이다.   
```sql
select
   /*+ INDEX_DESC (tbl_board pk_board) */
   *
from
   tbl_board
where
   bno > 0;
```
SQL의 실행 계획에서 주의해서 봐야 하는 부분은 1) SORT를 하지 않았다는 점, 2) TBL_BOARD를 바로 접근하는 것이 아니라 PK_BOARD를 이용해서 접근한 점, 3) RANGE SCAN DESCENDING, BY INDEX ROWID로 접근했다는 점이다.   

PK_BOARD라는 인덱스
---
데이터베이스에서 PK는 상당히 중요한 의미를 가지는데, 흔히 말하는 '식별자'의 의미와 '인덱스'의 의미를 가진다.   
'인덱스'는 말 그대로 '색인'이다. 우리가 가장 흔히 접하는 인덱스는 도서 뒤쪽에 정이되어 있는 색인이다. 색인을 이용하면 사용자들은 책 전체를 살펴볼 필요 없이 색인을 통해서 자신이 원하는 내용이 책의 어디에 있는지 알 수 있다.   
데이터베이스에 테이블을 만들 때 PK를 부여하면 지금까지 얘기한 '인덱스'라는 것이 만들어진다. 데이터베이스를 만들 때 PK를 지정하는 이유는 '식별'이라는 의미가 있지만, 구조상으로는 '인덱스'라는 존재(객체)가 만들어지는 것을 의미한다.   
인덱스와 실제 테이블을 연결하는 고리는 ROWID라는 존재이다. ROWID는 데이터베이스 내의 주소에 해당하는데 모든 데이터는 자신만의 주소를 가지고 있다.   

인덱스를 이용하는 정렬
---
인덱스에서 가장 중요한 개념 중 하나는 '정렬이 되어 있다는 점'이다. 정렬이 이미 되어 있는 상태이므로 데이터를 찾아내서 이들을 SORT 하는 과정을 생략할 수 있다.   
실무에서도 데이터의 양이 많고 정렬이 필요한 상황이라면 우선적으로 생각하는 것이 '인덱스'를 작성하는 것이다.   

인덱스와 오라클 힌트(hint)
---
오라클은 select문을 전달할 때 '힌트(hint)'라는 것을 사용할 수 있다. 힌트는 말 그대로 데이터베이스에 '지금 내가 전달한 select문을 이렇게 실행해 주면 좋겠습니다'라는 힌트이다. 힌트는 특이하게도 select문을 어떻게 처리하는지에 대한 얘기일 뿐이므로 힌트 구문에서 에러가 나도 전혀 SQL 실행에 지장을 주지 않는다. 따라서 힌트를 이용한 select문을 작성한 후에는 실행 계획을 통해서 개발자가 원하는 대로 SQL이 실행되는 지를 확인하는 습관을 가져야 한다.   
```sql
select * from tbl_board order by bno desc;

select 
  /*+INDEX_DESC (tbl_board pk_board) */
  *
from tbl_board;
```
위의 두 SQL은 동일한 결과를 생성하는 SQL이다.   
select문을 작성할 때 힌트는 잘못 작성되어도 실행할 때는 무시되기만 하고 별도의 에러는 발생하지 않는다. 힌트구문은 '/\*+'로 시작하고 '\*/'로 마무리된다. 힌트 자체는 SQL로 처리되지 않기 때문에 뒤에 칼럼명이 나오더라도 별도의 ','로 처리되지 않는다.   

INDEX_ASC, INDESC_DESC 힌트
---
흔히 목록 페이지에서 가장 많이 사용하는 힌트는 인덱스와 관련된 'INDEX_ASC', INDEX_DESC'힌트이다. ASC/DESC에서 알 수 있듯이 인덱스를 순서대로 이용할 것인지 역순으로 이용할 것인지를 지정하는 것이다. INDEX_ASC/DESC 힌트는 주로 'order by'를 위해서 사용한다고 생각하면 된다. 인덱스 자체가 정렬을 해 둔 상태이므로 이를 통해서 SORT 과정을 생략하기 위한 용도이다.   
INDEX_ASC/DESC 힌트는 테이블 이름과 인덱스 이름을 같이 파라미터로 사용한다. INDEX_ASC/DESC를 이용하는 경우에는 동일한 조건의 order by 구문을 작성하지 않아도 된다.   

ROWNUM과 인라인뷰
---
ROWNUM은 쉽게 생각해서 SQL이 실행된 결과에 넘버링을 해준다고 생각하면 된다. ROWNUM이라는 것은 데이터를 가져올 때 적용되는 것이고, 이 후에 정렬되는 과정에서는 ROWNUM이 변경되지 않는다는 것이다. SQL을 작성할 때 ROWNUM 조건은 반드시 1이 포함되어야 한다.   
인라인뷰는 논리적으로 어떤 결과를 구하는 SELECT문이 있고, 그 결과를 다시 대상으로 삼아서 SELECT를 하는 것이다.   
1. 필요한 순서로 정렬된 데이터에 ROWNUM을 붙인다.
2. 처음부터 해당 페이지의 데이터를 'ROWNUM <= 30'과 같은 조건을 이용해서 구한다.
3. 구해놓은 데이터를 하나의 테이블처럼 간주하고 인라인뷰로 처리한다.
4. 인라인뷰에서 필요한 데이터만을 남긴다.

Mybatis와 스프링에서 페이징 처리
---
페이징 처리를 위해서는 SQL을 실행할 때 몇 가지 파라미터가 필요하다는 점이다. 페이징 처리를 위해서는 필요한 파라미터는 1) 페이지 번호(pageNum), 2) 한 페이지당 몇 개의 데이터(amount)를 보여줄 것인지가 결정되어야만 한다.   
작성된 BoardMapper.xml에서는 XML의 CDATA처리가 들어간다. CDATA 섹션은 XML에서 사용할 수 없는 부등호를 사용하기 위함인데, XML을 사용할 경우에는 '\<, \>'는 태그로 인식하는데, 이로 인해 생기는 문제를 막기 위함이다.(&lt; 나 &gt;와 같은 특수 문자를 사용할 수도 있긴 하다.)   

페이징 처리할 때 필요한 정보
---
1. 현재 페이지 번호(page)
2. 이전과 다음으로 이동 가능한 링크의 표시 여부(prev, next)
3. 화면에서 보여지는 페이지의 시작 번호와 끝 번호(startPage, endPage)   
``` java
페이징의 끝 번호(endPage) 계산
this.endPage = (int)(Math.ceil(페이지번호 / 10.0)) * 10;

페이징의 시작 번호
this.startPage = this.endPage - 9;

total을 통한 endPage의 재계산
realEnd = (int) (Math.ceil((total * 1.0) / amount));
if(realEnd < this.endPage) {
   this.endPage = realEnd;
}

이전(prev) 계산
this.prev = this.startPage > 1;

다음(next) 계산
this.next = this.endPage < realEnd;
```

Mybatis의 동적 SQL
---
- if: test라는 속성과 함께 특정한 조건이 true가 되었을 때 포함된 SQL을 사용하고자 할 때 작성한다. If 안에 들어가는 표현식(expression) OGNL 표현식이라는 것을 이용한다.
- choose(when, otherwise): if와 달리 choose는 여러 상황들 중 하나의 상황에서만 동작한다.
- trim(where, set): trim, where, set은 단독으로 사용되지 않고 \<if\>, \<choose\>와 같은 태그들을 내포하여 SQL들을 연결해 주고, 앞 뒤에 필요한 구문들(AND, OR, WHERE 등)을 추가하거나 생략하는 역할을 한다.    
\<where\>의 경우 태그 안쪽에서 SQL이 생성될 때는 WHERE 구문이 붙고, 그렇지 않는 경우에는 생성되지 않는다.   
\<trim\>은 하위에서 만들어지는 SQL문을 조사하여 앞 쪽에 추가적인 SQL을 넣을 수 있다.
- foreach: foreach는 List, 배열, 맵 등을 이용해서 루프를 처리할 수 있다. 주로 IN 조건에서 많이 사용하지만, 경우에 따라서는 복잡한 WHERE조건을 만들때에도 사용할 수 있다. foreach를 배열이나 List를 이용하는 경우에는 item 속성만을 이용하면 되고, Map의 형태로 key와 value를 이용해야 할 때는 index와 item 속성을 둘 다 이용한다.
```xml
Map<String, String> map = new HashMap<>();
map.put("T", "TTTT");
map.put("C", "CCCC");
   
<foreach item="val" index="key" collection="map"></foreach>
```
Mybatis는 \<sql\>이라는 태그를 이용해서 SQL의 일부를 별도로 보관하고, 필요한 경우에 include시키는 형태로 사용할 수 있다. \<sql\> 태그는 id라는 속성을 이용해서 필요한 경우에 동일한 SQL의 일부를 재사용할 수 있게 한다.
```xml
<sql id="criteria"></sql>
<include refid="criteria"></include>
```

화면에서 검색 조건 처리
---
1. 페이지 번호가 파라미터로 유지되었던 것처럼 검색 조건과 키워드 역시 항상 화면 이동 시 같이 전송되어야 한다.
2. 화면에서 검색 버튼을 클릭하면 새로 검색을 한다는 의미이므로 1페이지로 이동한다.
3. 한글의 경우 GET 방식으로 이동하는 경우 문제가 생길 수 있으므로 주의해야 한다.   
항상 테스트는 영문과 한글을 모두 테스트해야 한다.   
   
UriComponentsBuilder를 이용하는 링크 생성   
org.springframework.web.util.UriComponentsBuilder는 여러 개의 파라미터들을 연결해서 URL의 형태로 만들어주는 기능을 가지고 있다. URL을 만들어주면 리다이렉트 하거나, \<form\>태그를 사용하는 상황을 많이 줄여줄 수 있다(가장 편리한 점은 한글 처리에 신경 쓰기 않아도 된다는 점이다.). UriComponentsBuilder로 생성된 URL은 화면에서도 유용하게 사용될 수 있는데, 주로 javaScript를 사용할 수 없는 상황에서 링크를 처리해야 하는 상황에서 사용된다.
``` java
UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
   .queryParam("pageNum", this.pageNum")
   .queryParam("amount", this.getAmount())
   .queryParam("type", this.getType())
   .queryParam("keyword", this.getKeyword());
   
return builder.toUriString();
```



part2
===
프로젝트 구동 시 관여하는 XML은 web.xml, root-context.xml, servlet-context.xml 파일이다. 이 파일들 중 web.xml은 Tomcat 구동과 관련된 설정이고, 나머지 두 파일은 스프링과 관련된 설정이다. 프로젝트의 구동은 web.xml에서 시작한다.   
root-context.xml에 정의된 객체(Bean)들은 스프링의 영역(Context) 안에 생성되고, 객체들 간의 의존성이 처리된다. root-context.xml이 처리된 후에는 스프링 MVC에서 사용하는 DispatcherServlet이라는 서블릿과 관련된 설정이 동작한다.   
org.springframework.web.servlet.DispatcherServlet 클래스는 스프링 MVC의 구조에서 가장 핵심적인 역할을 하는 클래스이다. 내부적으로 웹 관련 처리의 준비작업을 진행하는데 이때 사용하는 파일이 servlet-context.xml이다.   

스프링 MVC의 기본 구조
----
1. 사용자의 Request는 Front-Controller인 DispatcherServlet을 통해서 처리한다.
2. HandlerMapping은 Request의 처리를 담당하는 컨트롤러를 찾기 위해서 존재한다.
3. 적절한 컨트롤러가 찾아졌다면 HandlerAdapter를 이용해서 해당 컨트롤러를 동작시킨다.
4. Controller는 개발자가 작성하는 클래스로 실제 Request를 처리하는 로직을 작성하게 된다. 이때 View에 전달해야 하는 데이터는 주로 Model이라는 객체에 담아서 전달한다.
5. ViewResolver는 Controller가 반환한 결과를 어떤 View를 통해서 처리하는 것이 좋을지 해석하는 역할이다.
6. View는 실제로 응답 보내야 하는 데이터를 Jsp 등을 이용해서 생성하는 역할을 하게 된다. 만들어진 응답은 DispatcherServlet을 통해서 전송된다.   

Controller의 파라미터 수집
----
Controller를 작성할 때 가장 편리한 기능은 파라미터가 자동으로 수집되는 기능이다. 이 기능을 이용하면 매번 request.getParameter()를 이용하는 불편함을 없앨 수 있다.   
Controller가 파라미터를 수집하는 방식은 파라미터 타입에 따라 자동으로 변환하는 방식을 이용한다.   
동일한 이름의 파라미터가 여러 개 전달되는 경우에는 배열 또는 ArrayList<> 등을 이용해서 처리가 가능하다. 스프링은 파라미터의 타입을 보고 객체를 생성하므로 파라미터의 타입은 List<>와 같이 인터페이스 타입이 아닌 실제적인 클래스 타입으로 지정한다.   
스프링 MVC는 전달되는 파라미터가 동일한 이름으로 여러 개 존재하면 배열로 처리가 가능하므로 파라미터를 배열 타입으로 작성한다.

@InitBinder
----
파라미터의 수집을 다른 용어로는 'binding(바인딩)'이라고 한다. 변환이 가능한 데이터는 자동으로 변환되지만 경우에 따라서는 파라미터를 변환해서 처리해야 하는 경우도 존재한다. 예를 들어, 화면에서 '2018-01-01'과 같이 문자열로 전달된 데이터를 java.util.Date 타입으로 변환하는 작업이 그러하다. 스프링 Controller에서는 파라미터를 바인딩할 때 자동으로 호출되는 @InitBinder를 이용해서 이러한 변환을 처리할 수 있다.   
@InitBinder를 이용해서 날짜를 변환할 수도 있지만, 파라미터로 사용되는 인스턴스 변수에 @DateTimeFormat을 적용해도 변환이 가능하다.   

Model이라는 데이터 전달자
---
Controller의 메서드를 작성할 때는 특별하게 Model이라는 타입을 파라미터로 지정할 수 있다. Model 객체는 JSP에 컨트롤러에서 생성된 데이터를 담아서 전달하는 역할을 하는 존재이다.   

@ModelAttribute 어노테이션
---
스프링 MVC의 Controller는 기본적으로 Java Beans 규칙에 맞는 객체는 다시 화면으로 객체를 전달한다. 좁은 의미에서 Java Beans의 규칙은 단순히 생성자가 없거나 빈 생성자를 가져야 하며, getter/setter를 가진 클래스의 객체들은 의미한다. 파라미터로 사용된 SampleDTO의 경우는 Java Bean의 규칙에 맞기 때문에 자동으로 다시 화면까지 전달된다. 전달될 때에는 클래스명의 앞글자는 소문자로 처리된다.   
@ModelAttribute는 강제로 전달받은 파라미터를 Model에 담아서 전달하도록 할 때 필요한 어노테이션이다. @ModelAttribute가 걸린 파라미터는 타입에 관계없이 무조건 Model에 담아서 전달되므로, 파라미터로 전달된 데이터를 다시 화면에서 사용해야 할 경우에 유용하게 사용된다.   
기본 자료형에 @ModelAttribute를 적용할 경우에는 반드시 @ModelAttribute("page")와 같이 값(value)을 지정하도록 한다.   

RedirectAttributes
---
RedirectAttributes는 조금 특별하게도 일회성으로 데이터를 전달하는 용도로 사용한다.   
RedirectAttributes는 Model과 같이 파라미터로 선언해서 사용하고, addFlashAttribute(이름,값) 메소드를 이용해서 화면에 한 번만 사용하고 다음에는 사용되지 않는 데이터를 전달하기 위해서 사용한다.   

Controller의 리턴 타입
---
Controller의 메소드가 사용할 수 있는 리턴 타입은 주로 다음과 같다.
1. String: jsp를 이용하는 경우에는 jsp파일의 경로와 파일이름을 나타내기 위해서 사용한다.
2. void: 호출하는 URL과 동일한 이름의 jsp를 의미한다.
3. VO, DTO 타입: 주로 JSON 타입의 데이터를 만들어서 반환하는 용도로 사용한다.
4. ResponseEntity 타입: response 할 때 Http 헤더 정보와 내용을 가공하는 용도로 사용한다.
5. HttpHeaders: 응답에 내용 없이 Http 헤더 메세지만 전달하는 용도로 사용한다.   

MIME 타입
---
MIME타입이란 클라이언트에게 전송되는 문서의 다양성을 알려주기 위한 메커니즘이다. 웹에서 파일의 확장자는 별 의미가 없다. 그러므로 각 문서와 함께 올바른 MIME 타입을 전송하도록, 서버가 정확히 설정하는 것이 중요하다. 브라우저들은 리소스를 내려받았을 때 해야할 기본 동작이 무엇인지를 결정하기 위해 대게 MIME 타입을 사용한다.   

Controller의 Exception 처리
---
AOP: 핵심 로직은 아니지만 프로그램에서 필요한 '공통적인 관심사(cross-concern)는 분리'하자는 개념이다.   
@ControllerAdvice는 해당 객체가 스프링의 컨트롤러에서 발생하는 예외를 처리하는 존재임을 명시하는 용도로 사용하고, @ExceptionHandler는 해당 메서드가 () 들어가는 예외 타입을 처리한다는 것을 의미한다.

part1
====
src/main/resources: 실행할 때 참고하는 기본 경로(주로 설정 파일들을 넣는다)   
servlet-context.xml: 웹과 관련된 스프링 설정 파일   
web.xml: Tomcat의 web.xml파일   
pom.xml: Maven이 사용하는 pom.xml   
root-context.xml: 스프링 프레임워크에서 관리해야 하는 객체(Bean)를 설정하는 파일. 스프링에서 root-context.xml은 스프링이 로딩되면서 읽어 들이는 문서이므로, 주로 이미 만들어진 클래스들을 이용해서 스프링의 빈(Bean)으로 등록할 때 사용된다.   

경량 프레임워크(light-weight Framework): 과거 J2EE 기술은 너무나 복잡하고 방대했기 때문에, 특정 기능을 위주로 간단한 jar파일 등을 이용해서 모든 개발이 가능하도록 구성된 프레임워크      

스프링의 주요특징
-----------------
* POJO(Plain Old Java Project) 기반의 구성: 내부에는 객체 간의 관계를 구성할 수 있는 특징을 가지고 있다. 스프링은 다른 프레임워크들과 달리 이 관계를 구성할 때 별도의 API 등을 사용하지 않는 POJO의 구성만으로 가능하도록 제작되어 있다. 일반적인 Java 코드를 이용해서 객체를 구성하는 방식을 그대로 스프링에서 사용할 수 있다.
* 의존성 주입(DI)을 통한 객체 간의 관계 구성: 의존성(Dependency)이라는 것은 하나의 객체가 다른 객체 없이 제대로 된 역할을 할 수 없다는 것을 의미한다. 의존성은 하나의 객체가 다른 객체의 상태에 따라 영향을 받는 것을 의미한다. 주입을 받는 입상에서는 어떤 객체인지 신경 쓸 필요가 없다. 어떤 객체에 의존하든 자신의 역할은 변하지 않는다. 스프링에서는 'ApplicationContext'라는 존재가 필요한 객체들을 생성하고, 필요한 객체들을 주입하는 역할을 해 주는 구조이다. 스프링을 이용하면 개발자들은 기존의 프로그래밍과 달리 객체와 객체를 분리해서 생성하고, 이러한 객체들을 엮는(wiring) 작업을 하는 형태의 개발을 하게 된다. 스프링에서는 ApplicationContext가 관리하는 객체들을 '빈(Bean)'이라는 용어로 부르고, 빈과 빈 사이의 의존관계를 처리하는 방식으로 XML 설정, 어노테이션 설정, Java 설정 방식을 이용할 수 있다.
* AOP(Aspect-Oriented-Programming) 지원: 대부분의 시스템이 공통으로 가지고 있는 보안이나 로그, 트랜잭션과 같이 비즈니스 로직은 아니지만, 반드시 처리가 필요한 부분을 스프링에서는 '횡단 관심사'라고 한다. 스프링은 이러한 횡단 관심사를 분리해서 제작하는 것이 가능하다. AOP는 이러한 횡단 관심사를 모듈로 분리하는 프로그래밍의 패러다임이다.
* 편리한 MVC 구조
* WAS에 종속적이지 않은 개발 환경   

스프링에서 관리하는 객체를 빈(Bean)이라고 한다.   
@Component: 스프링에게 해당 클래스가 스프링에서 관리해야 하는 대상임을 표시하는 어노테이션   

스프링이 동작하면서 생기는 일
-----------------------
1. 스프링 프레임워크가 시작되면 먼저 스프링이 사용하는 메모리 영역을 만들게 되는데 이를 컨텍스트(Context)라고 한다. 스프링에서는 ApplicationContext라는 이름의 객체가 만들어진다.
2. 스프링은 자신이 객체를 생성하고 관리해야 하는 객체들에 대한 설정이 필요하다. 이에 대한 설정이 root-context.xml 파일이다.
3. root-context.xml에 설정되어 있는 <context:component-scan> 태그의 내용을 통해서 'org.zerock.sample' 패키지를 스캔(scan)하기 시작한다.
4. 해당 패키지에 있는 클래스들 중에서 스프링이 사용하는 @Component라는 어노테이션이 존재하는 클래스의 인스턴스를 생성한다.
5. Restaurant 객체는 Chef객체가 필요하다는 어노테이션(@Autowired) 설정이 있으므로, 스프링은 Chef 객체의 레퍼런스를 Restaurant 객체에 주입한다.   

JUnit
----
현재 테스트 코드가 스프링을 실행하는 역할을 할 것이라는 것을 @RunWith 어노테이션으로 표시한다.   
@ContextConfiguration은 지정된 클래스나 문자열을 이용해서 필요한 객체들을 스프링 내에 객체로 등록하게 된다.   
@Log4j는 Lombok을 이용해서 로그를 기록하는 Logger를 변수로 생성한다.   
@Autowired는 해당 인스턴스 변수를 스프링으로부터 자동으로 주입해 달하는 표시이다.   
@Test는 JUnit에서 테스트 대상을 표시하는 어노테이션이다.   
assertNotNull()은 해당 변수가 null이 아니어야만 테스트가 성공한다는 것을 의미한다.   

'Spring Legacy Project'로 생성한 경우에는 기본적으로 Log4j 설정이 있기 때문에 추가적인 설정 없이 @Log4j만으로 로그 객체를 준비할 수 있다.   
@Component는 해당 클래스가 스프링에서 객체로 만들어서 관리하는 대상임을 명시하는 어노테이션이다.   
@Autowired는 스프링 내부에서 자신이 특정한 객체에 의존적이므로 자신에게 해당 타입의 빈을 주입해주라는 표시이다. 스프링은 @Autowired 어노테이션을 보고 스프링 내부에 관리되는 객체(들) 중에 적당한 것이 있는지를 확인하고, 자동으로 주입해 준다.
@ContextConfiguration은 스프링이 실행되면서 어떤 설정 정보를 읽어 들어야 하는지 명시한다. 속성으로는 locations를 이용해서 문자열의 배열로 XML 설정 파일을 명시할 수도 있고, classes 속성으로 @Configuration이 적용된 클래스를 지정해 줄 수도 있다.   
@RunWith는 테스트 시 필요한 클래스를 지정한다. 스프링은 SpringJUnit4ClassRunner 클래스가 대상이 된다.   
@Test는 JUnit에서 해당 메서드가 JUint 상에서 단위 테스트의 대상인지 알려준다.   
@AllArgsConstructor는 인스턴스 변수로 선언된 모든 것을 파라미터로 받는 생성자를 작성하게 된다.   
@RequiredArgsConstructor는 @NonNull이나 final이 붙은 인스턴스 변수에 대한 생성자를 만들어 낸다.
@Bean은 XML설정에서 <bean> 태그와 동일한 역할을 한다고 생각하면 된다. @Bean이 선언된 메서드의 실행 결과로 반환된 객체는 스프링의 객체로 등록된다.   

Mapper
--------------
XML 매퍼를 이용할 때 신경 써야 하는 부분은 <mapper> 태그의 namespace 속성값이다. MyBatis는 Mapper 인터페이스와 XML을 인터페이스의 이름과 namespace 속성값을 가지고 판단한다.   
<select> 태그의 id 속성값은 메서드의 이름과 동일하게 맞춰야 한다. <select> 태그의 경우 resultType 속성을 가지는데 이 값은 인터페이스에 선언된 메서드의 리턴 타입과 동일하게 작성한다.
