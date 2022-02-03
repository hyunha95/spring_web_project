# spring_web_project   

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
