package com.pyeondeuk.model;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.pyeondeuk.db.SqlSessionManager;

public class EventDAO {
    private SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSessionFactory();

    public EventDTO getEvents(int i ) {
        EventDTO events = null;
        try (SqlSession session = sqlSessionFactory.openSession()) {
            events = session.selectOne("getEvents", i);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return events;
    }
}
